const app = angular.module("stegoApp", []);

app.directive("fileModel", [
  "$parse",
  function ($parse) {
    return {
      restrict: "A",
      link: function (scope, element, attrs) {
        let model = $parse(attrs.fileModel);
        let modelSetter = model.assign;
        element.bind("change", function () {
          scope.$apply(function () {
            modelSetter(scope, element[0].files[0]);
          });
        });
      },
    };
  },
]);

app.controller("MainController", [
  "$scope",
  "$http",
  function ($scope, $http) {
    $scope.stegoImageUrl = null;
    $scope.extractedText = "";

    $scope.hideText = function () {
      let formData = new FormData();
      formData.append("image", $scope.imageFile);
      formData.append("message", $scope.inputText);
      formData.append("password", $scope.password);

      $http
        .post("http://127.0.0.1:5000/hide", formData, {
          headers: { "Content-Type": undefined },
          responseType: "blob",
        })
        .then(function (response) {
          let blob = new Blob([response.data], { type: "image/png" });
          $scope.stegoImageUrl = URL.createObjectURL(blob);
        })
        .catch(function (error) {
          console.error("Error hiding text:", error);
          alert("Error hiding text: " + (error.data?.error || "Unknown error"));
        });
    };

    $scope.extractText = function () {
      let formData = new FormData();
      formData.append("image", $scope.extractImageFile);
      formData.append("password", $scope.extractPassword);

      $http
        .post("https://jayanthbottu-steganography.onrender.com", formData, {
          headers: { "Content-Type": undefined },
        })
        .then(function (response) {
          $scope.extractedText = response.data.message;
        })
        .catch(function (error) {
          console.error("Error extracting text:", error);
          alert(
            "Error extracting text: " + (error.data?.error || "Unknown error")
          );
        });
    };
  },
]);
