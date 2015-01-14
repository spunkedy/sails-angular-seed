module.exports = function(grunt) {
    grunt.config.set('sass', {
        dev: {
            options: {
                loadPath: ["assets/styles/ui","assets/styles/","assets/"],
                compass: true,
                style: 'expanded'
            },
            files: [
                {
                    expand: true,
                    cwd: 'assets/styles/',
                    src: ['main.scss'],
                    dest: '.tmp/public/styles/',
                    ext: '.css'
                }, {
                    expand: true,
                    cwd: 'assets/vendor/',
                    src: ['main.scss'],
                    dest: '.tmp/public/vendor/',
                    ext: '.css'
                }           
            ]
        }
    });
    grunt.loadTasks('node_modules/grunt-contrib-sass/tasks');
};