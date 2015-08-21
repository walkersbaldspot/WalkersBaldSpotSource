var gulp = require('gulp'), 
    sass = require('gulp-sass') 
    notify = require("gulp-notify") 
    bower = require('gulp-bower');

var config = {
    publicDir: "./src/static",
    sassPath: "././resources/sass",
     bowerDir: "././bower_components" 
  }

  gulp.task('bower', function() { 
    return bower()
         .pipe(gulp.dest(config.bowerDir)) 
});

// Move fontawesome files
gulp.task('icons', function() { 
    return gulp.src(config.bowerDir + "/fontawesome/fonts/**.*") 
        .pipe(gulp.dest(config.publicDir + "/fonts")); 
});



gulp.task('css', function() {
    return gulp.src(config.sassPath + '/style.scss')
    .pipe(sass({
        includePaths: [
          "./resources/sass",
                 config.bowerDir + "/bootstrap-sass-official/assets/stylesheets",
                 config.bowerDir + "/fontawesome/scss"],
    }))
    .pipe(gulp.dest(config.publicDir + '/css'));
});

gulp.task('jScript', function() {
    return gulp.src(config.bowerDir + "/bootstrap-sass-official/assets/javascripts/*.min.js") 
        .pipe(gulp.dest(config.publicDir + "/js")); 
});



// Rerun the task when a file changes
 gulp.task('watch', function() {
     gulp.watch(config.sassPath + '/**/*.scss', ['css']); 
});

  gulp.task('default', ['bower', 'icons', 'css','jScript']);
