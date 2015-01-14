/**
 * grunt/pipeline.js
 *
 * The order in which your css, javascript, and template files should be
 * compiled and linked from your views and static HTML files.
 *
 * (Note that you can take advantage of Grunt-style wildcard/glob/splat expressions
 * for matching multiple files.)
 */



// CSS files to inject in order
//
// (if you're using LESS with the built-in default config, you'll want
//  to change `assets/styles/importer.less` instead.)
var cssFilesToInject = [
  'styles/**/*.css',
  'bower_components/font-awesome/css/*.min.css'
];


// Client-side javascript files to inject in order
// (uses Grunt-style wildcard/glob/splat expressions)
var jsFilesToInject = [
  
  // Load sails.io before everything else
  'js/dependencies/sails.io.js',

  'bower_components/jquery/dist/jquery.min.js',  
  'bower_components/underscore/underscore-min.js',
  'bower_components/underscore.string/dist/underscore.string.min.js',
  'bower_components/angular/angular.js',
  'bower_components/angular-route/angular-route.min.js',
  'bower_components/angular-animate/angular-animate.min.js',
  "bower_components/angular-sails-bind/dist/angular-sails-bind.min.js",


  "bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js",
  "bower_components/jquery-spinner/dist/jquery.spinner.min.js",
  "bower_components/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js",
  "bower_components/jquery-steps/build/jquery.steps.min.js",
  "bower_components/jquery.steps/build/jquery.steps.min.js",
  "bower_components/toastr/toastr.min.js",
  "bower_components/bootstrap-file-input/bootstrap.file-input.js",
  "bower_components/jquery.slimscroll/jquery.slimscroll.min.js",
  "bower_components/slimScroll/jquery.slimscroll.min.js",
  
  "bower_components/holderjs/holder.js",
  "bower_components/raphael/raphael-min.js",
  "bower_components/morris.js/morris.js",

  // Dependencies like jQuery, or Angular are brought in here
  'js/dependencies/**/*.js',


  "bower_components/flot/jquery.flot.js",
  "bower_components/flot/jquery.flot.resize.js",
  "bower_components/flot/jquery.flot.pie.js",
  "bower_components/flot/jquery.flot.stack.js",
  "bower_components/flot/jquery.flot.time.js",
  "bower_components/gauge.js/dist/gauge.min.js",
  "bower_components/jquery.easy-pie-chart/dist/angular.easypiechart.min.js",
  "bower_components/angular-wizard/dist/angular-wizard.min.js",

  'js/app.js',
  'js/shared/*.js',
  'js/UI/*.js',
  'js/Form/*.js',
  'js/Table/*.js',
  'js/Task/*.js',
  'js/Chart/*.js',
  // All of the rest of your client-side js files
  // will be injected here in no particular order.
  'js/**/*.js'
];


// Client-side HTML templates are injected using the sources below
// The ordering of these templates shouldn't matter.
// (uses Grunt-style wildcard/glob/splat expressions)
//
// By default, Sails uses JST templates and precompiles them into
// functions for you.  If you want to use jade, handlebars, dust, etc.,
// with the linker, no problem-- you'll just want to make sure the precompiled
// templates get spit out to the same file.  Be sure and check out `tasks/README.md`
// for information on customizing and installing new tasks.
var templateFilesToInject = [
  'templates/**/*.html'
];



// Prefix relative paths to source files so they point to the proper locations
// (i.e. where the other Grunt tasks spit them out, or in some cases, where
// they reside in the first place)
module.exports.cssFilesToInject = cssFilesToInject.map(function(path) {
  return '.tmp/public/' + path;
});
module.exports.jsFilesToInject = jsFilesToInject.map(function(path) {
  return '.tmp/public/' + path;
});
module.exports.templateFilesToInject = templateFilesToInject.map(function(path) {
  return 'assets/' + path;
});
