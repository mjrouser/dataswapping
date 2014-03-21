
    var hbtn = document.querySelector("#hbtn");
    var mbtn = document.querySelector("#mbtn");
    var sbtn = document.querySelector("#sbtn");
    
    var homeDiv = document.querySelector("#home");
    var mapsDiv = document.querySelector("#maps_data")
    var vizCols = document.querySelector("#vizcols")
    var sCols = document.querySelector("#scols")
    var hli = document.querySelector("#hli")
    var mli = document.querySelector("#mli")
    var sli = document.querySelector("#sli")

    
    hbtn.addEventListener("click", toggleClassValues, false)
    mbtn.addEventListener("click", toggleClassValues, false)
    sbtn.addEventListener("click", toggleClassValues, false)
    
    
    function toggleClassValues(e) {
        var elementID = e.target.id;
        
        if (elementID == "hbtn") {
            addClass(mapsDiv, "hide");
            removeClass(homeDiv, "hide");
            addClass(hli, "active");
            removeClass(mli, "active");
            removeClass(sli, "active")


            
        } else if (elementID == "mbtn") {
            addClass(homeDiv, "hide");
            removeClass(mapsDiv, "hide");
            addClass(vizCols, "col-md-9");
            removeClass(sCols, "col-md-9");
            addClass(sCols, "col-md-3");
            removeClass(vizCols, "col-md-3");
            addClass(mli, "active");
            removeClass(hli, "active")
            removeClass(sli, "active")
            

            
        } else {
            addClass(homeDiv, "hide");
            removeClass(mapsDiv, "hide");
            addClass(vizCols, "col-md-3");
            removeClass(vizCols, "col-md-9");
            addClass(sCols, "col-md-9");
            removeClass(sCols, "col-md-3");
            addClass(sli, "active")
            removeClass(hli, "active")
            removeClass(mli, "active")
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




