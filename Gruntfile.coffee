module.exports = (grunt) ->
  _buildDir = 'build/'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      build: [_buildDir]
    coffeelint:
      options:
        max_line_length:
          level: 'ignore'
      src: ['src/*.coffee']
    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: 'src/'
        src: ['*.coffee']
        dest: _buildDir
        ext: '.js'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', () ->
    grunt.task.run ['coffeelint', 'coffee']
    grunt.file.mkdir 'logs'

  grunt.registerTask 'lint', ['coffeelint']
