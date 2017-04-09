define('module1', [], function () {
    function sayHello() {
        console.log('Hello')
    }

    return {
        sayHello: sayHello
    }
})

// require(['module1'], function (m1) {
//     m1.sayHello()
// })


// define(function(require) {
//     'use strict';
//     var m1 = require('module1')
//     m1.sayHello()
// });

// define(['module1'], function (m1) {
//     m1.sayHello()
// })

define(['module1'], function() {
    'use strict';
    var m1 = require('module1')
    m1.sayHello()
});