/** @type {import('next').NextConfig} */

const nextConfig = {
  output: 'export',
  distDir: '../public',
  env: {
    name: 'Lab Images POC',
    description: 'Custom lab workspace images.',
    icon: '/img/logo.svg',
    listUrl: 'https://sharrison-sans.github.io/kasm-workspaces-poc/',
    contactUrl: 'https://github.com/sharrison-SANS/kasm-workspaces-poc/issues',
  },
  reactStrictMode: true,
  basePath: '/kasm-workspaces-poc/1.0',
  trailingSlash: true,
  images: {
    unoptimized: true,
  }
}

module.exports = nextConfig
