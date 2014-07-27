//define router class

var MapRouter = Backbone.Router.extend ({
      routes: {
                 ''  : 'showHome',
                 'home' : 'showHome',
                 'maps_data': "showMapsdata",
                 'stories': 'showStories'  
      },

      showHome: function(){
        console.log("home");
        $("#home").removeClass('hide');
        $("#maps_data").addClass('hide');
      

      },

      showMapsdata: function(){
      	 console.log("maps_data");
         $("#home").addClass('hide');
         $('#maps_data').removeClass('hide');
         $('#vizcols').addClass('col-md-9').removeClass('col-md-3');
         $('#scols').addClass('col-md-3').removeClass('col-md-9');
         $('#maptabs').addClass('nav-justified');
         $('#maptabs').removeClass('nav-stacked');
         $('#twtabs').addClass('nav-stacked');
         $('#twtabs').removeClass('nav-justified');
         $('#tw1').removeClass('col-md-4');
         $('#tw2').removeClass('col-md-4');
         $('#tw3').removeClass('col-md-3');


      },

      showStories: function(){
        console.log("stories");
      	$('#home').addClass('hide');
        $('#maps_data').removeClass('hide');
        $('#vizcols').addClass('col-md-3').removeClass('col-md-9');
        $('#scols').addClass('col-md-9').removeClass('col-md-3');
        $('#maptabs').addClass('nav-stacked');
        $('#maptabs').removeClass('nav-justified');
        $('#twtabs').addClass('nav-justified');
        $('#twtabs').removeClass('nav-stacked');
        $('#tw1').addClass('col-md-4');
        $('#tw2').addClass('col-md-4');
        $('#tw3').addClass('col-md-3');


      }

});

//define new instance of router

var myMapRouter = new MapRouter();

//navigation


Backbone.history.start();

//$('#myTab a').click(function (e) {
//  e.preventDefault()
 // $(this).tab('show')
//})
    

/*
    var hmbtn = document.querySelector("#hmbtn");
    var mapbtn = document.querySelector("#mapbtn");
    var storybtn = document.querySelector("#storybtn");

    var home = document.querySelector("home");
    var maps_data = document.querySelector("maps_data");
    var stories = document.querySelector("stories"):

    hmbtn.addEventListener("click", toggleClassValues, false)
    mapbtn.addEventListener("click", toggleClassValues, false)
    storybtn.addEventListener("click", toggleClassValues, false)
    
    function toggleClassValue(e){
        var elementID = e.target.id;

        if (elementID == "hmbtn"){
            addClass(maps_data, "hide");
            addClass(stories, "hide");
        }

        else if (elementID == "maps_data"){
            addClass(home, "hide");
            addClass(storties, "hide");
        }

        else {
            addClass(home, "hide");
            addClass(maps_data, "hide");
        }
    }



    function addClass(element, classToAdd) {
        var currentClassValue = element.className;
        
        if (currentClassValue.indexOf(classToAdd) == -1) {
            if ((currentClassValue == null) || (currentClassValue === "")) {
                element.className = classToAdd;
            } else {
                element.className += " " + classToAdd;
            }
        }
    }
         
    function removeClass(element, classToRemove) {
        var currentClassValue = element.className;
    
        if (currentClassValue == classToRemove) {
            element.className = "";
            return;
        }
    
        var classValues = currentClassValue.split(" ");
        var filteredList = [];
    
        for (var i = 0 ; i < classValues.length; i++) {
            if (classToRemove != classValues[i]) {
                filteredList.push(classValues[i]);
            }
        }
    
        element.className = filteredList.join(" ");
    }
    */