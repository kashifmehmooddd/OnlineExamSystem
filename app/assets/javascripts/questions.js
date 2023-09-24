function question()
{
  if (document.getElementById("question_base").value == "text")
  {
    for (let i = 1; i <= 4; i++)
    {
      document.getElementById("option-" + i.toString()).style.display = 'none';
      document.getElementById("option-" + i.toString()).removeAttribute('required')

    }

    $("#text-answer").attr("placeholder", "Correct Answer");
  }
  else
  {
    for (let i = 1; i <= 4; i++)
    {
      $('#option-'+i.toString()).prop('required',true)
      document.getElementById("option-" + i.toString()).style.display = 'block';
      console.log(i);


    }
    $("#text-answer").attr("placeholder", "Correct Answer (Option number only!)");
  }

}
