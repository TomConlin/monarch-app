### Data and Ontology Visual Explorer

The Data and Ontology Visual Explorer (DOVE) widget creates interactive ontology backed charts.
Currently the DOVE widget provides a framework for creating a horizontal bar chart that displays
data structured as a tree.  The chart can be traversed by drilling down into branches of data using
navigation arrows and breadcrumbs. In addition, the widget provides a basic UI  to allow a user to
transition between stacked and grouped configurations, log and linear scale, and filter out groups that contain no data.

#### Please note the barchart code is currently being refactored.  The below documentation refers to the legacy code in datagraph.js.

Steps for Adding the Monarch Graph Widget to Your Webpage

   This page describes how to include the Monarch Graph Widget on any webpage. Steps are
   provided for adding required JavaScript files*, adding parameters to the widget call,
   and adding the widget to the html file.

   *Required files are available at: 
       https://github.com/monarch-initiative/monarch-app/tree/master/widgets/datagraph
    
1. Add the Required JavaScript Libraries and Image

   The following .js code libraries are required:
   
        jQuery (tested with 1.11.0)
        d3 (tested with 3.5.5)
        
   The custom JavaScript file for the Monarch Graph widget is required.
   
        datagraph.js
        
   Create a new html file and add all required JavaScript files within the html <head> tags
        For example:

        <head>
             <script src="js/jquery-1.11.0.min.js"></script>
             <script src="js/d3.min.js"></script>
             <script src="js/datagraph.js"></script>
        </head>

2. Add a List of  and a jQuery Function Call

   Create a list of statistics as an array of Javascript
    objects with the following attributes:

        [
          { 
            "id": "HP:0000707",
            "label": "Nervous System",
            "counts": [
              {
                "value": 21290,
                "name": "Human"
              },
              {
               "value": 38136,
               "name": "Mouse"
              }
             ] 
           },...
        ]


   Add a jQuery .ready function that will add the widget to an empty div tag (see Step 3) as
    follows (The following example assumes you are adding the widget to a div with a
    class=".graph_container" and have stored your data in the variable 'graph'):

        jQuery(document).ready(function(){
                datagraph.init(".graph-container",graph);
        });

   Alternatively, data can be stored from a URL with jQuery or D3, for example:

        jQuery(document).ready(function(){

            //Using D3
            d3.json("/labs/datagraph.json",function(error,data) {
                var graph = data.dataGraph;
                datagraph.init(".graph-container",json);
            });

            //Or alternatively using jQuery
            jQuery.getJSON( "/labs/datagraph.json", function(data) {
                var graph = data.dataGraph;
                datagraph.init(".graph-container",graph);
            });
        });

   Storing Layered Data

   Layered data can be stored in the folowing format:

        [
          {
            "id": "HP:0000707",
            "label": "Nervous System",
            "counts": [
              {
                "value": 21290,
                "name": "Human"
              },
              {
               "value": 38136,
               "name": "Mouse"
              }
             ],
             "subGraph":[
                 {
                   "label":"Nervous System Morphology",
                   "id":"HP:0012639",
                   "counts": [
                     {
                       "value":7431,
                       "name":"Human",
                     {
                       "value":24948,
                       "name":"Mouse"
                     }
                    ],
                 },...
           },...
        ]

   For a practical example see http://monarchinitiative.org/labs/datagraph.json

   Widget Parameters
        Additional parameters can be set to customize the data graph, such as setting
        the title, axis labels, colors, and chart size.

   Basic Settings:

        a. datagraph.chartTitle - Chart Title
        b. datagraph.xAxisLabel - X Axis Label
        c. datagraph.width - Chart Width
        d. datagraph.height - Chart Height
        e. datagraph.useLegend - Use Chart Legend (default: true)
        f. datagraph.color - CSS colors
            
   The color variable is a JSON object with the following format:
   
                 datagraph.color = { 
                     first  : '#44A293',   //First group
                     second : '#A4D6D4',   //Second group
                     ... 

                 yLabel : { 
                     fill  : '#000000',
                     hover : '#EA763B'
                 },
                 arrow : {
                     fill  : "#496265",
                     hover : "#EA763B"
                 },
                 bar : {
                       fill  : '#EA763B'
                 },
                   crumb : {
                       top   : '#496265',
                       bottom: '#3D6FB7',
                       hover : '#EA763B'
                   }
               };
   Any setting can be updated without creating the entire color object,
   for example:
   
                datagraph.color.first = '#44A293';
                datagraph.color.second = '#A4D6D4';
                  
  Note: Colors are set in the order they appear in the JSON object

  Advanced Settings:
       
        a. datagraph.isYLabelURL = true; - Is the yLabel linkable?
        b. datagraph.yLabelBaseURL = '/phenotype' - Y axis base URLs
                                                Group IDs are appended to the base URL
        c. datagraph.margin = {top: 40, right: 80, bottom: 200, left: 320} - Chart Margins
        d. datagraph.title = { 
            'margin-left' : '360px',
            'padding-bottom': '10px',
            'font-size' : '20px',
            'font-weight': 'bold'
         };

  Bread Crumbs:
           The Monarch Graph creates bread crumbs when traversing layered data.  
           When using breadcrumbs the first "crumb" can be set since this value
           is not stored in the JSON object.
           
        a. datagraph.firstCrumb = "Phenotypic Abnormality"; - Name of first bread crumb


   Add the statistics array or URL and the jQuery function between <script> tags in the html <head>
        Example:

        <script type="text/javascript">
            jQuery(document).ready(function(){
            
                jQuery.getJSON( "/labs/datagraph.json", function(data) {
                    var graph = data.dataGraph;
                    datagraph.init(".graph-container",graph);
                });
            });
        </script>

3. Add the Widget <div>:

   Add an empty <div> tag in the body of the html file.
    For example:

    <body>    
         <div class="graph-container"></div>
    <body>


4. Add the HTML File on the Server
Just add your html file and the required .js libraries where they are visible on your server.
You're done!

Please contact us at info@monarchinitiative.org if you have any problems or questions.
