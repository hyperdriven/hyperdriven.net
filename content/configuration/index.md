---
date: 2017-03-13T23:18:00+00:00
title: Configuration
weight: 30
---

Configuration of core features are done via Environment Variables, in accordence with [12 factor](https://12factor.net/config) principles.

## Environment

The stage in your deployment pipeline the api is currently running in. A value of `production` changes behviour for some features (such as whether stack traces are logged during panic recovery). Other values, such as `staging`, can be used but currently have no meanin in the framework other than the one you give it in your own code.

- var: `HYPERDRIVE_ENV`
- default: `development`
- type: `string`

## Port 

The port the server should listen on.

  - var: `PORT`
  - default: `5000`
  - type: `int`
  
## Compression 

Accepts a value between `-2` and `9`. Invalid values will be silently discarded and the default of `-1` will be used. More info on compression levels can be found in hyperdrive's [godoc](https://godoc.org/github.com/hyperdriven/hyperdrive#API.CompressionMiddleware), but generally corresponds to `zlib` compression levels.
  
  - var: `GZIP_LEVEL`
  - default: `-1`
  - type: `int`

## CORS

### Enable CORS Middleware

Set this to `false` to disable CORS support.

- var: `CORS_ENABLED`
- default: `true`
- type: `bool`

### Allowed Headers

A comma-seperated list of headers to allow and expose during CORS requests. These will be appended to the default set of headers that are always allowed: `Accept`, `Accept-Language`, `Content-Language`, and `Content-Type`.

- var: `CORS_HEADERS`
- type: `string`)

### Allowed Origins

A comma-seperated list of origins to allow during CORS requests. These will replace the default value, which is to allow all origins.


  - `CORS_ORIGINS`
  - default `*`
  - type: `string`
  
### Allow Credentials
  
Set this to `false` to disable authenticated CORS requests.

- var: `CORS_CREDENTIALS`
- default: `true`
- type: `bool`

