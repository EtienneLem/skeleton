![Skeleton](https://s3.amazonaws.com/skeleton/skeleton.png)

[Express](https://github.com/visionmedia/express) 3.0 framework-less app structure generator<br>
[Documentation](http://etiennelem.github.com/skeleton) •
[Blog post](http://heliom.ca/en/blog/skeleton)

## Usage
### Installation
```sh
$ npm install -g skeleton
```

### Generate a project
```sh
$ skeleton myapp
$ skeleton --directory ~/Desktop myapp
$ skeleton --renderer jade --css less myapp
$ skeleton myapp --js js
```

### Start your application
```sh
$ node server.js
$ node server.js -p 1337
```

### Help
```sh
$ skeleton --help

  Usage: skeleton [options] myapp

  -h, --help       display this help message
  -v, --version    display the version number
  -f, --force      force on non-empty directory
  -n, --nolog      do not print any message to process.stdout
  -d, --directory  the output directory (default: ./)
  -r, --renderer   template engine [ejs, jade] (default: ejs)
  -c, --css        stylesheet engine [stylus, less, css] (default: stylus)
  -j, --js         javascript engine [coffee, js] (default: coffee)
```

## Running tests
```sh
$ npm test
```

## Features
* Clean encapsulated Object-Oriented framework base (see [#not-quite-a-framework](#not-quite-a-framework))
* CoffeeScript only. No js/compilation whatsoever
* Automatically load `lib/**` & `app/controllers/**` files
* Use [connect-assets](https://github.com/TrevorBurnham/connect-assets); The *“Rails 3.1-style asset pipeline for Node.js”*
* Partials/layout ([removed from Express 3.0](https://github.com/visionmedia/express/wiki/Migrating-from-2.x-to-3.x)) via [express-partials](https://github.com/publicclass/express-partials)*
  * *At least until layout support is added to [ejs](https://github.com/visionmedia/ejs)
  * *Not in the package when using [Jade](https://github.com/visionmedia/jade)
* Heroku-ready (see https://devcenter.heroku.com/articles/nodejs)

### Not quite a framework
I guess this could be considered the generator part of a framework.
It does create a view-controller user interface which does a bunch of things a framework would do, but once your project is generated it is up to you.

## Generated app structure
See [example](https://github.com/EtienneLem/skeleton/tree/master/example).
```
myapp
├─┬ app
│ ├── app.coffee
│ ├─┬ assets
│ │ ├─┬ css
│ │ │ └── styles.styl
│ │ └─┬ js
│ │   └── scripts.coffee
│ ├─┬ controllers
│ │ └── application_controller.coffee
│ ├─┬ helpers
│ │ └── index.coffee
│ ├─┬ routes
│ │ └── index.coffee
│ └─┬ views
│   ├── 404.ejs
│   ├── index.ejs
│   └── layout.ejs
├─┬ config
│ └── boot.coffee
├─┬ lib
│ └─┬ myapp
│   └── my_custom_class.coffee
├── package.json
├── Procfile
├── public
├── README.md
└── server.js
```

## Todo
* Add [Haml](https://github.com/visionmedia/haml.js) support
* Add [Sass](https://github.com/visionmedia/sass.js) support

## License
Copyright (c) 2012 Etienne Lemay etienne@heliom.ca, [@EtienneLem](https://twitter.com/EtienneLem)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.