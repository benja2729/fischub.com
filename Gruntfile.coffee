
module.exports = (grunt) ->

  grunt.initConfig
    #pkg: grunt.file.readJSON 'package.json'

    copy:
      dev:
        files: [
          src: ['src/*'], dest: 'dev/', filter: 'isFile', flatten: true, expand: true
        ,
          expand: true
          cwd: 'components/'
          src: ['lib/**/*.js', 'bootstrap/js/*.js']
          dest: 'dev/js/lib/'
          flatten: true
          filter: 'isFile'
        ]

    coffee:
      options:
        bare: true
      dev:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'dev/js/'
        ext: '.js'

    #less:
    #  dev:

  # Loading Tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  # Defining Tasks
  grunt.registerTask 'dev', ['copy:dev', 'coffee:dev', 'less:dev']
  # grunt.registerTask 'dist', ['copy:dist', 'coffee:dist', 'less:dist']

  grunt.registerTask 'default', ['dev']