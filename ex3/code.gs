//Đường link deploy app-script: https://script.google.com/macros/s/AKfycbxJiKdEhc_ii0czdNhA6XDkNpmnfkWHWaOaq2hfBozgVpBa3YGJ4a4mohe3vM8jXmLU/exec

function uploadFileToGoogleDrive(base64, name, contentType) {
  var folder;
  var folders = DriveApp.getFoldersByName("ex2");
  if (folders.hasNext()) {
    folder = folders.next();
  } else {
    folder = DriveApp.createFolder("ex2");
  }
  try {
    var file = folder.createFile(Utilities.newBlob(Utilities.base64Decode(base64, Utilities.Charset.UTF_8), contentType, `${Date.now()}-${name}`));
    file.setSharing(DriveApp.Access.ANYONE_WITH_LINK, DriveApp.Permission.VIEW);
    return ContentService.createTextOutput(JSON.stringify({
      "drive": file.getUrl(),
      "download": file.getDownloadUrl()
    }));
  } catch (err) {
    return ContentService.createTextOutput(err.toString());
  }
}

const doGet = (event) => {
  return ContentService.createTextOutput("Hello world!");
};

const doPost = (request) => {
  var data = JSON.parse(request["postData"]["contents"]);
  return uploadFileToGoogleDrive(data["content"].toString(), data["name"].toString(), data["contentType"].toString());
};