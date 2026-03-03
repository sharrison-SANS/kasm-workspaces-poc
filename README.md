# Kasm Workspaces Registry

A [Kasm Workspace Registry](https://www.kasmweb.com/docs/develop/guide/workspace_registry.html) site built from the [kasmtech/workspaces_registry_template](https://github.com/kasmtech/workspaces_registry_template). Provides a self-hosted registry of custom lab workspace images for use with Kasm Workspaces.

## Workspace Images

| Image | Description |
|---|---|
| Terminal | Lightweight CLI workspace with tmux, screen, nano, and dnsutils |
| DFIR Desktop | Digital forensics workstation with Autopsy, Ghidra, Volatility3, Wireshark, CyberChef, and more |
| Kali Desktop | Penetration testing lab with kali-tools-top10, Metasploit, Nmap, and Burp Suite |

Images are built and pushed to GHCR from [kasm-lab-images](https://github.com/sharrison-SANS/kasm-lab-images).

## Project Structure

```
kasm-workspaces-poc/
  build_all_branches.sh     # Multi-branch registry builder
  processing/               # JSON processing scripts
  site/                     # Next.js registry site
  workspaces/               # Workspace definitions (workspace.json + icons)
```

## Adding to Kasm

1. In Kasm admin, go to **Infrastructure > Docker Registries > Add** and add GHCR with a PAT that has `read:packages` scope
2. Go to **Workspaces > Workspace Registry > Add New**
3. Enter: `https://sharrison-sans.github.io/kasm-workspaces-poc/`

## CI/CD

The registry site is built and deployed to GitHub Pages automatically when:
- Workspace definitions or site files change on `main`
- A `registry-rebuild` dispatch event is received (triggered by image builds in kasm-lab-images)
- Manually via workflow dispatch
