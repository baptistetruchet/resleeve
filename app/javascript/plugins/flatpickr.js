import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
// import 'json';

const forbidates = document.querySelector("#forbidden-dates").value;

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

const arrayForbid = [];
forbidates.split('X').forEach((s) => {
  let arr = s.split('|')
  arrayForbid.push({
    from: arr[0],
    to: arr[1]
  });
});

console.log(arrayForbid);

flatpickr("#range_start", {
  altInput: true,
  minDate: "today",
  disable: arrayForbid,
  plugins: [new rangePlugin({ input: "#range_end"})]
});
