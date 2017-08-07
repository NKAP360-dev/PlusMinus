using Microsoft.Bot.Builder.FormFlow;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Emma.Entity
{
    [Serializable]
    public class FeedbackForm
    {
        [Prompt(new string[] { "What is your name?" })]
        public string Name { get; set; }

        
        [Prompt("What department are you from?")]
        public string Department { get; set; }
        
        [Prompt("What's your feedback?")]
        public string Feedback { get; set; }

        public static IForm<FeedbackForm> BuildForm()
        {
            return new FormBuilder<FeedbackForm>()
                .Field(nameof(Feedback), active: FeedbackEnabled)
                .AddRemainingFields()
                .Build();
        }

        private static bool FeedbackEnabled(FeedbackForm state) => !string.IsNullOrWhiteSpace(state.Name);
    }
}