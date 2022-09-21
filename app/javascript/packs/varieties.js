import $ from 'jquery'
import 'select2'

$(function () {
  $('#schedule_variety_id').select2({
    theme: 'bootstrap-5',
    tags: true,
    dropdownAutoWidth: true,
    width: 400
  });
});
