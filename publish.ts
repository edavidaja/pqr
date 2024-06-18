async function updateConnect(
  server = Deno.env.get("CONNECT_SERVER"),
  key = Deno.env.get("CONNECT_API_KEY"),
  pythonVersion = Deno.env.get("PYTHON_VERSION"),
  quartoVersion = Deno.env.get("QUARTO_VERSION"),
  rVersion = Deno.env.get("R_VERSION"),
): Promise<string> {
  const installations = JSON.stringify({
    title: `Python ${pythonVersion} | Quarto ${quartoVersion} | R ${rVersion}`,
    cluster_name: "Kubernetes",
    name: `ghcr.io/edavidaja/pqr:python${pythonVersion}-quarto${quartoVersion}-r${rVersion}`,
    python: {
      installations: [{
        path: `/opt/python/${pythonVersion}/bin/python`,
        version: pythonVersion,
      }],
    },
    quarto: {
      installations: [{
        path: `/opt/quarto/bin/quarto`,
        version: quartoVersion,
      }],
    },
    r: {
      installations: [{
        path: `/opt/R/${rVersion}/bin/R`,
        version: rVersion,
      }],
    },
  });


  const response = await fetch(`${server}/__api__/v1/environments`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Key ${key}`,
    },
    body: installations,
  });


  const result = await response.json();
  console.log(result);
  return result;
}

await updateConnect();
