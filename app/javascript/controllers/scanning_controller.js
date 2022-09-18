import { Controller } from "@hotwired/stimulus";
import * as ScanditSDK from "scandit-sdk";

// Connects to data-controller="scanning"
export default class extends Controller {
  connect() {
    // console.log("Scanner connected");
    var scanditBarcodePicker = document.getElementById(
      "scandit-barcode-picker"
    );
    var barcodeResultElement = document.getElementById(
      "scandit-barcode-result"
    );
    // var starterButton = document.getElementById("start-scanner-button");
    // console.log(scanditBarcodePicker);
    var licenseKey = scanditBarcodePicker.dataset.scanditId;

    startBarcodePicker;
    // starterButton.addEventListener("click", startBarcodePicker);
    ScanditSDK.configure(`${licenseKey}`, {
      engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk@5.x/build/",
    })
      .then(() => {
        return ScanditSDK.BarcodePicker.create(
          document.getElementById("scandit-barcode-picker"),
          {
            accessCamera: true,
            visible: true,
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
                "data-matrix",
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
              }).then((response) => {
                if (response.redirected) {
                  window.location.href = response.url;
                }
              });
            })
            .on("scanError", (error) => {
              console.error(error);
            })
            .on("ready", () => {
              barcodeResultElement.innerHTML = `<i class="fa-solid fa-circle-check fa-xs"></i> The BarcodePicker is ready!`;
              // starterButton.style.display = "inline-block";
            });
        });
      })
      .catch((error) => {
        console.error(error);
        alert(error);
      });

    function startBarcodePicker() {
      // starterButton.style.display = "none";
      barcodeResultElement.innerHTML =
        "The BarcodePicker is accessing the camera...";
      scanditBarcodePicker.accessCamera().then(() => {
        barcodeResultElement.innerHTML = "";
        scanditBarcodePicker.setVisible(true);
      });
    }
  }
}
