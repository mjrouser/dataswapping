var hmbtn = document.querySelector("#hmbtn");
var mapbtn = document.querySelector("#mapbtn");
var storybtn = document.querySelector("#storybtn");

var home = document.querySelector("home");
var maps_data = document.querySelector("maps_data");
var stories = document.querySelector("stories");
var vizcols = document.querySelector("vizcols");
var scols = document.querySelector("scols");

hmbtn.addEventListener("click", toggleClassValues, false)
mapbtn.addEventListener("click", toggleClassValues, false)
storybtn.addEventListener("click", toggleClassValues, false)
    
    function toggleClassValues(e){
        var elementID = e.target.id;

        if (elementID == "hmbtn"){
            addClass(maps_data, "hide");
            
        }

        else if (elementID == "maps_data"){
            addClass(home, "hide");
            addClass(vizcols, "col-md-9");
            addClass(scols, "col-md-3");

        }

        else {
            addClass(home, "hide");
            addClass(vizcols, "col-md-3");
            addClass(scols, "col-md-9");
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


$("#hmbtn").click(function(){ 
    $("div.home")removeClass("hide");
    $("div.maps_data")addClass("hide");
})

$("#maps_data").click(function(){
    $("div.home")addClass("hide");
    $("div.maps_data")removeClass("hide")
})

$(#)



