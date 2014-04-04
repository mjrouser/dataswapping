
    var ubtn = document.querySelector("#ubtn");
    var busbtn = document.querySelector("#busbtn");
    var combtn = document.querySelector("#combtn");
    var fbtn = document.querySelector("#fbtn");
    var cbtn = document.querySelector("#cbtn");
    
    var upkeep = document.querySelector("#upkeep");
    var business = document.querySelector("#business")
    var complaint = document.querySelector("#complaint")
    var fire = document.querySelector("#fire")
    var crime = document.querySelector("#crime")
   

    
    ubtn.addEventListener("click", toggleClassValues, false)
    busbtn.addEventListener("click", toggleClassValues, false)
    combtn.addEventListener("click", toggleClassValues, false)
    fbtn.addEventListener("click", toggleClassValues, false)
    cbtn.addEventListener("click", toggleClassValues, false)
    
    
    function toggleClassValues(e) {
        var elementID = e.target.id;
        
        if (elementID == "ubtn") {
            addClass(business, "hide");
            removeClass(upkeep, "hide");
            addClass(complaint, "hide");
            addClass(fire, "hide");
            addClass(crime, "hide")


            
        } else if (elementID == "busbtn") {
            addClass(upkeep, "hide");
            removeClass(business, "hide");
            addClass(complaint, "hide");
            addClass(fire, "hide");
            addClass(crime, "hide");
            

        } else if  (elementID == "combtn") {
            addClass(upkeep, "hide");
            addClass(business, "hide");
            removeClass(complaint, "hide");
            addClass(fire, "hide");
            addClass(crime, "hide"); 

        } else if  (elementID == "fbtn") {
            addClass(upkeep, "hide");
            addClass(business, "hide");
            addClass(complaint, "hide");
            removeClass(fire, "hide");
            addClass(crime, "hide");        
            

            
        } else {
            addClass(upkeep, "hide");
            addClass(business, "hide");
            addClass(complaint, "hide");
            addClass(fire, "hide");
            removeClass(crime, "hide");
           
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




