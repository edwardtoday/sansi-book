var path = require("path");

module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-gitbook');
    grunt.loadNpmTasks('grunt-gh-pages');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.initConfig({
        'gitbook': {
            development: {
                output: path.join(__dirname, ".grunt/gitbook"),
                input: "./",
                title: "Sansi book",
                description: "This work contains all documentation written by Pei Qing while working at Sansi.",
                github: "edwardtoday/sansi-book"
            }
        },
        'gh-pages': {
            options: {
                base: '.grunt/gitbook'
            },
            src: ['**'],
            travis: {
                options: {
                    repo: 'https://' + process.env.GH_TOKEN + '@github.com/edwardtoday/sansi-book.git',
                    silent: true
                },
                src: ['**']
            }
        },
        'clean': {
            files: '.grunt'
        }
    });

    grunt.registerTask('publish', [
        'gitbook',
        'gh-pages',
        'clean'
    ]);
    grunt.registerTask('default', 'gitbook');
};