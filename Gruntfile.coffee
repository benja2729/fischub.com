
module.exports = (grunt) ->

  grunt.initConfig
    #pkg: grunt.file.readJSON 'package.json'

    copy:
      lib:
        files: [
          expand: true
          cwd: 'components/'
          src: ['lib/**/*.js', 'bootstrap/js/*.js']
          dest: 'js/lib/'
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
        dest: 'js/'
        ext: '.js'

    ember_templates:
      options:
        templateName: (path) ->
          path.replace /src\/templates\//, ''
      dev:
        files: 'js/templates.js': ['src/templates/**/*']

    less:
      options:
        paths: ['components/bootstrap/less', 'src/less']
        strictImports: true
      dev:
        files: 'css/style.css': 'src/less/**/*.less'

  # Loading Tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-templates'

  # Defining Tasks
  grunt.registerTask 'compile', ['copy:lib', 'coffee:dev', 'ember_templates:dev', 'less:dev']
  # grunt.registerTask 'dist', ['copy:dist', 'coffee:dist', 'less:dist']

  grunt.registerTask 'default', ['dev']