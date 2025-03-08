<div align="center">
  <img src="https://raw.gabrielecanepa.com/raw.svg" width="200">
  <hr>
  <a href="https://github.com/gabrielecanepa/raw/actions/workflows/optimize-images.yml">
    <img src="https://github.com/gabrielecanepa/raw/actions/workflows/optimize-images.yml/badge.svg">
  </a>
</div>
<br>

Versioned static resources delivered at `raw.gabrielecanepa.com` via [Cloudflare Workers](https://workers.cloudflare.com).

## Usage

Use this URL pattern to link a resource in the [`lib`](./lib) directory:

```sh
https://raw.gabrielecanepa.com/{filename}
```

### Versioning and branching

To link a specific version, append the `v` parameter followed by a version or commit SHA (full or abbreviated):

```sh
https://raw.gabrielecanepa.com/{filename}?v={version|commit_sha}
```

To target a specific branch, use the `b` parameter with the branch name:

```sh
https://raw.gabrielecanepa.com/{filename}?b={branch}
```

If a parameter is invalid, the latest version from the default branch will be used.

### Examples

Using the asset `avatar-notion.png`.

- Latest version<br>
  https://raw.gabrielecanepa.com/avatar-notion.png
  <div><img width="60" src="https://raw.gabrielecanepa.com/avatar-notion.png?"></div>

- Commit [`e9546a2`](https://github.com/gabrielecanepa/raw/commit/e9546a2)<br>
  https://raw.gabrielecanepa.com/avatar-notion.png?v=e9546a2<br>
  <div><img width="60" src="https://raw.gabrielecanepa.com/avatar-notion.png?v=e9546a2"></div>

- Release [`v1.0.1`](https://github.com/gabrielecanepa/raw/releases/tag/v1.0.1)<br>
  https://raw.gabrielecanepa.com/avatar-notion.png?v=1.0.1<br>
  <div><img width="60" src="https://raw.gabrielecanepa.com/avatar-notion.png?r=1&v=1.0.1"></div>

- Branch [`colorize`](https://github.com/gabrielecanepa/raw/tree/colorize)<br>
  https://raw.gabrielecanepa.com/avatar-notion.png?b=colorize<br>
  <div><img width="60" src="https://raw.gabrielecanepa.com/avatar-notion.png?b=colorize&"></div>

- Wrong parameter fallback<br>
  https://raw.gabrielecanepa.com/avatar-notion.png?v=wrong<br>
  <div><img width="60" src="https://raw.gabrielecanepa.com/avatar-notion.png?v=wrong"></div>

## Development

### Worker

To set up the worker, switch to the `worker` directory and install the dependencies:

```sh
cd worker
pnpm install
```

Change the variables in [`wrangler.jsonc`](./worker/wrangler.jsonc) and run the worker locally:

```sh
pnpm run dev
```

Deploy by either:

- Pushing to the default branch
- Running the deploy script:

  ```sh
  pnpm run deploy
  ```

### Image optimization

Image assets are optimized automatically using [this workflow](https://github.com/gabrielecanepa/raw/actions/workflows/optimize-images.yml). The action also creates compressed WebP version of new images.

### Releases

To create a release, push a new tag using the following convention:

- Major `v1` - new collection of assets
- Minor `v1.2` - new and updated assets
- Patch `v1.2.3` - minor updates to existing assets

For example, to release `v1.0.1`:

```sh
git tag -a v1.0.1 -m "chore: release v1.0.1"
git push origin v1.0.1
```

A GitHub release will be automatically created using [this workflow](https://github.com/gabrielecanepa/raw/actions/workflows/release.yml).

## License

All files are public domain [unless otherwise specified](LICENSE).
