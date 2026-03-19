# nur-packages

Personal [NUR](https://github.com/nix-community/NUR) repository for `sedlund`.

![Build and populate cache](https://github.com/sedlund/nur-packages/workflows/Build%20and%20populate%20cache/badge.svg)
[![Cachix Cache](https://img.shields.io/badge/cachix-sedlund-blue.svg)](https://sedlund.cachix.org)

## Take a Peek

Take a peek at what I offer in store:

```bash
nix flake show github:sedlund/nur-packages
```

## Cachix

Add the `sedlund` Cachix cache declaratively:

```nix
nix.settings = {
  extra-substituters = [ "https://sedlund.cachix.org" ];
  extra-trusted-public-keys = [
    "sedlund.cachix.org-1:M7fyJk3z+yaJKCyI8U3fE7JH/v4yVYykmAVp6sXrB2o="
  ];
};
```

## Packages

| Package  | Description                                                 | URL                                |
| -------- | ----------------------------------------------------------- | ---------------------------------- |
| `ghoten` | OpenTofu fork with ORAS backend and additional integrations | https://github.com/vmvarela/ghoten |
