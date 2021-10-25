$(function() {
  $("#select--classroom").on("change", function() {
    $.ajax({
      type: 'GET',
      url: '/teachers/students/alergy_checks/creator/get_students',
      data: {
        classroom_id: $("#select--clasroom").val()
      },
    }).done(function(data){
      $('.student-area').html(data)
    })
  });
});