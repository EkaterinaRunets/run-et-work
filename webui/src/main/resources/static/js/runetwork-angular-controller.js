'use strict';

runetworkApp.controller('sampleUsersController', function ($scope, $http) {
    $scope.users = [];

    this.loadUsers = function () {
        $http.get(serverUrl + '/get-users').then(function(response) {
                $scope.users = response.data;
                console.log('success on get users');
                $('.content').removeClass('hidden')
            },
            function() {
                console.log('error on get users');
            });
    };
});