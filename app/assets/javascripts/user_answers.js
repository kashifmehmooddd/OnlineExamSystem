var count = 0;

function start(ids)
{
  count = 0;
  document.getElementById("answer-" + ids[count]).setAttribute("style", "display: block !important;");
  document.getElementById("question-" + ids[count]).setAttribute("style", "display: block !important;");
  document.getElementById("start-button").style.display = 'none';
  document.getElementById("next-button").setAttribute("style", "display: block !important;");
  if (count == ids.length - 1) {
      document.getElementById("next-button").setAttribute("style", "display: none !important;");
      document.getElementById("submit-button").setAttribute("style", "display: block !important;");
      count = 0;


    }
  count++;
}

function disappear(ids)
{

  if (document.getElementById("answer-" + ids[count - 1]).value == "")
  {
      alert("You cannot skip the question!")
  }
  else {

    document.getElementById("answer-" + ids[count]).setAttribute("style", "display: block !important;");
    document.getElementById("question-" + ids[count]).setAttribute("style", "display: block !important;");
    if (count != 0) {
      document.getElementById("answer-" + ids[count - 1]).setAttribute("style", "display: none !important;");
      document.getElementById("question-" + ids[count - 1]).setAttribute("style", "display: none !important;");
      console.log(document.getElementById("answer-" + ids[count - 1]).value);
    }
    if (count == ids.length - 1) {
      document.getElementById("next-button").setAttribute("style", "display: none !important;");
      document.getElementById("submit-button").setAttribute("style", "display: block !important;");
      count = 0;
    }
    count++;
  }
}
