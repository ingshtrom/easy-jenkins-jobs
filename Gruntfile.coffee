module.exports = (grunt) ->
  grunt.initConfig
    globalConfig:
      pub: 'pub'
      src: 'src'
      test: 'test'
    pkg: grunt.file.readJSON 'package.json'
    'clean':
      all: ['<%= globalConfig.pub %>/**/*.js']
      src: ['<%= globalConfig.pub %>/src/**/*.js']
      test: ['<%= globalConfig.pub %>/test/**/*.js']
    'coffeelint':
      options:
        max_line_length:
          level: 'ignore'
      src: [
        '<%= globalConfig.src %>/**/*.coffee',
        '!<%= globalConfig.src %>/**/*-spec.coffee'
      ]
      test: ['<%= globalConfig.test %>/**/*-spec.coffee']
    'coffee':
      src:
        files: [
          {
            expand: true
            flatten: true
            cwd: '<%= globalConfig.src %>'
            src: ['*.coffee', '!*-spec.coffee']
            dest: '<%= globalConfig.pub %>/src'
            ext: '.js'
          }
        ]
      test:
        files: [
          {
            expand: true
            flatten: true
            cwd: '<%= globalConfig.test %>'
            src: ['*-spec.coffee']
            dest: '<%= globalConfig.pub %>/test'
            ext: '.js'
          }
        ]
    'mocha-chai-sinon':
      run:
        src: ['<%= globalConfig.pub %>/test/**/*-spec.js']
        options:
          ui: 'bdd'
          reporter: 'spec'
      coverage:
        src: ['<%= globalConfig.pub %>/test/**/*-spec.js']
        options:
          ui: 'bdd'
          reporter: 'html-cov'
          quiet: true
          filter: '/foo/foo1/'
          captureFile: './coverage.html'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-chai-sinon'

  grunt.registerTask 'default', () ->
    grunt.task.run ['clean:all']
    grunt.task.run ['coffeelint', 'coffee']
    grunt.file.mkdir 'logs'

  grunt.registerTask 'dist', () ->
    grunt.task.run ['coffeelint:src', 'coffee:src']
    grunt.file.mkdir 'logs'

  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'lint:src', ['coffeelint:src']
  grunt.registerTask 'lint:test', ['coffeelint:test']

  grunt.registerTask 'build', () ->
    grunt.task.run ['clean:all', 'coffeelint', 'coffee']

  grunt.registerTask 'test', () ->
    grunt.task.run ['coffeelint:test', 'coffee:test', 'mocha-chai-sinon']
