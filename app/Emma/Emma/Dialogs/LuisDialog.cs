using Emma.DAO;
using Emma.Entity;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Builder.FormFlow;
using Microsoft.Bot.Builder.Luis;
using Microsoft.Bot.Builder.Luis.Models;
using Microsoft.Bot.Connector;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Emma.Dialogs
{
    [LuisModel("d5522e7c-5610-4433-8072-e0594affe1c0", "796a1db52bd24c8489d2cb90ceaddb6a")] // App ID, Programmatic API Key
    [Serializable]
    public class LuisDialog : LuisDialog<object>
    {
        ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();

        [LuisIntent("greeting")]
        public async Task greeting(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("greeting");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"Hello");
            }


            context.Wait(MessageReceived);
        }

        [LuisIntent("about me")]
        public async Task about_me(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("about me");
            EntityRecommendation rec;
            if (possibleAns.Count > 0)
            {
                if (result.TryFindEntity("name", out rec))
                {
                    string name = rec.Entity;
                    Boolean checkIfAnswered = false;

                    foreach (ChatBotAnswer cba in possibleAns)
                    {
                        if (cba.entityName != null && cba.entityName.ToLower().Contains("name"))
                        {
                            checkIfAnswered = true;
                            await context.PostAsync($"{cba.answer}");
                            break;
                        }
                    }

                    if (!checkIfAnswered)
                    {
                        await context.PostAsync($"I am an assistant");
                    }

                }
                else
                {
                    possibleAns.RemoveAll(x => x.entityName != null);
                    Random rdm = new Random();
                    int r = rdm.Next(possibleAns.Count);
                    await context.PostAsync($"{possibleAns[r].answer}");
                }
            }
            else
            {
                await context.PostAsync($"I am an assistant.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("help")]
        public async Task help(IDialogContext context, LuisResult result)
        {
            var reply = context.MakeMessage();
            List<CardAction> cardButtons = new List<CardAction>();
            List<string> allHelpQuestions = cbaDAO.getChatBotHelpQuestions();
            foreach (string qn in allHelpQuestions)
            {
                CardAction CardButton = new CardAction()
                {
                    Type = "imBack",
                    Title = qn,
                    Value = qn
                };
                cardButtons.Add(CardButton);
            }
           
            HeroCard hc = new HeroCard()
            {
                Title = "Help Enquiry",
                Subtitle = "You can try asking me these questions"
            };
            hc.Buttons = cardButtons;
            //reply.AddHeroCard("Help Enquiry", cardButtons);
            reply.Attachments.Add(hc.ToAttachment());
            await context.PostAsync(reply);
        }

        [LuisIntent("insult")]
        public async Task insult(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("insult");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"Thats not nice of you.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("compliments")]
        public async Task compliments(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("compliments");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"Thank you.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("eligibility enquiry")]
        public async Task EligibilityEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("eligible enquiry");
            EntityRecommendation rec;
            if (result.TryFindEntity("eligibilityCondition", out rec))
            {
                string condition = rec.Entity;
                Boolean checkIfAnswered = false;
                if (possibleAns.Count > 0)
                {
                    foreach (ChatBotAnswer cba in possibleAns)
                    {
                        if (cba.entityName != null && cba.entityName.ToLower().Contains(condition))
                        {
                            checkIfAnswered = true;
                            await context.PostAsync($"{cba.answer}");
                            break;
                        }
                    }

                    if (!checkIfAnswered)
                    {
                        await context.PostAsync($"I am unable to check for eligibility at this moment.");
                    }
                }
            }
            else
            {
                await context.PostAsync($"Registered staffs are eligible to apply for courses.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("application registration enquiry")]
        public async Task ApplicationRegistrationEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("application registration enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your registration enquiry.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("form difference enquiry")]
        public async Task FormDifferenceEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("form difference enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("trf definition enquiry")]
        public async Task TRFDefinitionEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("trf definition enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("sponsorship form definition enquiry")]
        public async Task SponsorshipFormDefinitionEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship form definition enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("msp bond requirements enquiry")]
        public async Task MSPBondRequirementsEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("msp bond requirements enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("course enquiry")]
        public async Task CourseEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("course enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("application help enquiry")]
        public async Task ApplicationHelpEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("application help enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("application status enquiry")]
        public async Task ApplicationStatusEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("application status enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("hr approval gst enquiry")]
        public async Task HRApprovalGSTEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("hr approval gst enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("compulsory course registration enquiry")]
        public async Task CompulsoryCourseRegistrationEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("compulsory course registration enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("course completion submission enquiry")]
        public async Task CourseCompletionSubmissionEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("course completion submission enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }

        [LuisIntent("incomplete course enquiry")]
        public async Task IncompleteCourseEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("incomplete course enquiry");
            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);

                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I am unable to process your request now.");
            }
            context.Wait(MessageReceived);
        }
        
        [LuisIntent("")]
        [LuisIntent("None")]
        public async Task None(IDialogContext context, LuisResult result)
        {
            List<string> possibleAns = new List<string>();
            possibleAns.Add("Sorry, I do not understand what you are saying");
            possibleAns.Add("I am unable to process this request yet. Maybe in the near future perhaps.");

            Random rdm = new Random();
            int r = rdm.Next(possibleAns.Count);

            await context.PostAsync($"{possibleAns[r].ToString()}");
            context.Wait(MessageReceived);
        }

        [LuisIntent("feedback")]
        public async Task Feedback(IDialogContext context, LuisResult result)
        {
            try
            {
                await context.PostAsync("That's great. You will need to provide few details about yourself before giving feedback. If you will like to cancel the feedback, please reply quit.");
                var feedbackForm = new FormDialog<FeedbackForm>(new FeedbackForm(), FeedbackForm.BuildForm, FormOptions.PromptInStart);
                context.Call(feedbackForm, FeedbackFormComplete);
            }
            catch (Exception)
            {
                await context.PostAsync("Something really bad happened. You can try again later meanwhile I'll check what went wrong.");
                context.Wait(MessageReceived);
            }
        }

        private async Task FeedbackFormComplete(IDialogContext context, IAwaitable<FeedbackForm> result)
        {
            try
            {
                var feedback = await result;
                Boolean success = cbaDAO.insertFeedback(feedback.Name, feedback.Feedback);
                if (!success)
                    await context.PostAsync("I was not able to send your message. Something went wrong.");
                else
                {
                    await context.PostAsync("Thanks for the feedback.");
                    await context.PostAsync("What else would you like to do?");
                }

            }
            catch (FormCanceledException)
            {
                await context.PostAsync("Don't want to send feedback? Alright!");
            }
            catch (Exception)
            {
                await context.PostAsync("Something really bad happened. You can try again later meanwhile I'll check what went wrong.");
            }
            finally
            {
                context.Wait(MessageReceived);
            }
        }

        /*
        [LuisIntent("course description enquiry")]
        public async Task CourseDescriptionEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("about me");
            EntityRecommendation rec;
                if (result.TryFindEntity("course", out rec))
                {
                    string name = rec.Entity;
                    Boolean checkIfAnswered = false;

                    foreach (ChatBotAnswer cba in possibleAns)
                    {
                        if (cba.entityName != null && cba.entityName.ToLower().Contains("name"))
                        {
                            checkIfAnswered = true;
                            await context.PostAsync($"{cba.answer}");
                            break;
                        }
                    }

                    if (!checkIfAnswered)
                    {
                        await context.PostAsync($"I am an assistant");
                    }

                }
                else
                {
                    possibleAns.RemoveAll(x => x.entityName != null);
                    Random rdm = new Random();
                    int r = rdm.Next(possibleAns.Count);
                    await context.PostAsync($"{possibleAns[r].answer}");
                }
            
            context.Wait(MessageReceived);
        }*/
    }
}