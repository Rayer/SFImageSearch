document.addEventListener("DOMContentLoaded", function (event) {
});

document.addEventListener("contextmenu", function (event) {
  console.log(event)
  if (event.srcElement && isImgUrl(event.srcElement.src)) {
    safari.extension.setContextMenuEventUserInfo(event, { "imageSrc": event.srcElement.src });
  }
});

safari.self.addEventListener("message", messageHandler);

function messageHandler(message) {
    console.log(message)
    
}

function isImgUrl(url) {
  if(!isValidUrl(url)) {
    return false;
  }
  let pure = getPathFromUrl(url)
  return (pure.match(/\.(jpeg|jpg|gif|png|svn|tiff)$/) != null);
}

function getPathFromUrl(url) {
  return url.split("?")[0];
}

const isValidUrl = (string) => {
  try {
    new URL(string);
    return true;
  } catch (_) {
    return false;
  }
}
