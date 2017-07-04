using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void showHighlights(object sender, EventArgs e)
        {
            eventsPanel.Visible = false;
            highlightsPanel.Visible = true;
            highlightsBtn.CssClass = "linkStyleActive";
            eventsBtn.CssClass = "linkStyle";
            
        }

        protected void showEvents(object sender, EventArgs e)
        {
            eventsPanel.Visible = true;
            highlightsPanel.Visible = false;
            eventsBtn.CssClass = "linkStyleActive";
            highlightsBtn.CssClass = "linkStyle";
           
        }
    }
}