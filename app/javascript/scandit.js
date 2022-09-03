import dotenv from "dotenv";

var scanditBarcodePicker = document.getElementById("scandit-barcode-picker");
var barcodeResultElement = document.getElementById("scandit-barcode-result");
var starterButton = document.getElementById("start-scanner-button");

var licenseKey = dotenv.config(SCANDIT);

starterButton.addEventListener("click", startBarcodePicker);

ScanditSDK.configure(`${licenseKey}`, {
  engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk@5.x/build/",
})
  .then(() => {
    return ScanditSDK.BarcodePicker.create(
      document.getElementById("scandit-barcode-picker"),
      {
        accessCamera: false,
        visible: false,
        playSoundOnScan: true,
        vibrateOnScan: true,
        scanSettings: new ScanditSDK.ScanSettings({
          enabledSymbologies: [
            "ean8",
            "ean13",
            "upca",
            "upce",
            "code128",
            "code39",
            "code93",
            "itf",
          ],
          codeDuplicateFilter: 1000,
        }),
      }
    ).then((barcodePicker) => {
      barcodeResultElement.innerHTML = "The BarcodePicker is loading...";
      scanditBarcodePicker = barcodePicker;
      barcodePicker
        .on("scan", (scanResult) => {
          document.getElementById("scandit-barcode-result").innerHTML =
            scanResult.barcodes.reduce((string, barcode) => {
              return `${string}${ScanditSDK.Barcode.Symbology.toHumanizedName(
                barcode.symbology
              )}: ${barcode.data}<br/>`;
            }, "") +
            scanResult.texts.reduce((string, text) => {
              return `${string}${text.value
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")} (${text.location})<br/>`;
            }, "");
          console.log(scanResult);
          let csrfToken = document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content");
          fetch("/medicine", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": csrfToken,
            },
            body: JSON.stringify({
              medicine: {
                symbology: scanResult.barcodes[0].symbology,
                data: scanResult.barcodes[0].data,
              },
            }),
          });
        })
        .on("scanError", (error) => {
          console.error(error);
        })
        .on("ready", () => {
          barcodeResultElement.innerHTML = "The BarcodePicker is ready!";
          starterButton.style.display = "inline-block";
        });
    });
  })
  .catch((error) => {
    console.error(error);
    alert(error);
  });

function startBarcodePicker() {
  starterButton.style.display = "none";
  barcodeResultElement.innerHTML =
    "The BarcodePicker is accessing the camera...";
  scanditBarcodePicker.accessCamera().then(() => {
    barcodeResultElement.innerHTML = "";
    scanditBarcodePicker.setVisible(true);
  });
}
