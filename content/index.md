---
date: 2017-03-13T23:09:00+00:00
title: Hyperdrive
type: index
weight: 10
---

## Introduction

Hyperdrive is an opinionated microframework for creating hypermedia APIs in Go.

Hyperdrive helps you focus on writing great APIs, with little-to-no boiler plate. It aims to be as idiomatic as possible, using Go's `http.Handler` pattern, as much as possible. The framework embraces the REST Architectural Style, helps promote hypermedia best practices and then gets out of your way.

## Features

- Resource-Oriented
- Flexible and Powerful HTTP Method handling
- Automatic Content Negotiation
- Built-In Resource Versioning, via Media Types
- Automatic `CORS` (Cross Origin Resource Sharing) support
- Request Parameter Whitelisting (e.g. allowed vs. required input)
- Automatic Discovery URL
- Built-In HATEOS support, via `LINK` & `LOCATION` headers, as well as `HAL` (Hypertext Application Language)
- Automatic `X-HTTP-Method-Override` support
- and more!

## Install


```sh
go get github.com/hyperdriven/hyperdrive
```

OR

```sh
glide get github.com/hyperdriven/hyperdrive
```
