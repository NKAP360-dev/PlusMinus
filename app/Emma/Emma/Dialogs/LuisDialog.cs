using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Builder.FormFlow;
using Microsoft.Bot.Builder.Luis;
using Microsoft.Bot.Builder.Luis.Models;
using Microsoft.Bot.Connector;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
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
                Boolean success = cbaDAO.insertFeedback(feedback.Name, feedback.Feedback, feedback.Department, DateTime.Now);
                if (!success)
                    await context.PostAsync("I was not able to send your message. Something went wrong.");
                else
                {
                    //to send success email
                    ChatBotFeedbackSettingsDAO cbfsDAO = new ChatBotFeedbackSettingsDAO();
                    ChatBotFeedbackSettings currentSettings = cbfsDAO.getCurrentSettings();
                    if (currentSettings.enabled.Equals("y"))
                    {
                        SmtpClient client = new SmtpClient("Host");
                        client.Host = "smtp.gmail.com";
                        client.Port = 587;
                        client.EnableSsl = true;
                        client.Credentials = new NetworkCredential(currentSettings.smtpUsername, currentSettings.smtpPassword);
                        MailMessage mailMessage = new MailMessage();
                        mailMessage.IsBodyHtml = true;
                        mailMessage.From = new MailAddress("DO_NOT_REPLY@amkthk.gov.sg");
                        mailMessage.To.Add(currentSettings.emailToSendTo);
                        mailMessage.Body = $"Hi, <br /><br /> New feedback received from {feedback.Name}, {feedback.Department}. <br /><br />His/her feedback is: <br />{feedback.Feedback}.";
                        mailMessage.Subject = "New Feedback";
                        client.Send(mailMessage);
                    }
                    await context.PostAsync("Thanks for the feedback.");
                    await context.PostAsync("What else would you like to do?");
                }

            }
            catch (FormCanceledException)
            {
                await context.PostAsync("Don't want to send feedback? Alright!");
            }
            catch (Exception e)
            {
                await context.PostAsync(e.Message);
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

        [LuisIntent("advance course application enquiry")]
        public async Task AdvanceCourseApplicationEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("advance course application enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("learning budget entitlement enquiry")]
        public async Task LearningBudgetEntitlementEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("learning budget entitlement enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("learning budget enquiry")]
        public async Task LearningBudgetEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("learning budget enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("sponsorship application criteria enquiry")]
        public async Task SponsorshipApplicationCriteriaEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship application criteria enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("course catalog enquiry")]
        public async Task CourseCatalogEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("course catalog enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("sponsorship application status enquiry")]
        public async Task SponsorshipApplicationStatusEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship application status enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("sponsorship application enquiry")]
        public async Task SponsorshipApplicationEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship application enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("bond requirements enquiry")]
        public async Task BondRequirementsEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("bond requirements enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("education liaising enquiry")]
        public async Task EducationLiaisingEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("education liaising enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("study leave enquiry")]
        public async Task StudyLeaveEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("study leave enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("time allowance enquiry")]
        public async Task TimeAllowanceEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("time allowance enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("sponsorship allowance enquiry")]
        public async Task SponsorshipAllowanceEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship allowance enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("sponsorship leave enquiry")]
        public async Task SponsorshipLeaveEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("sponsorship leave enquiry");
            EntityRecommendation rec;
            if (possibleAns.Count > 0)
            {
                if (result.TryFindEntity("sponsorshipType", out rec))
                {
                    string sponsorshipType = rec.Entity;
                    Boolean checkIfAnswered = false;

                    foreach (ChatBotAnswer cba in possibleAns)
                    {
                        if (cba.entityName != null && cba.entityName.ToLower().Contains(sponsorshipType))
                        {
                            checkIfAnswered = true;
                            await context.PostAsync($"{cba.answer}");
                            break;
                        }
                    }

                    if (!checkIfAnswered)
                    {
                        await context.PostAsync($"I do not have the answer to your questions just yet.");
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
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }
            context.Wait(MessageReceived);
        }
        [LuisIntent("course completion submission material enquiry")]
        public async Task CourseCompletionSubmissionMaterialEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("course completion submission material enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("reimbursement enquiry")]
        public async Task ReimbursementEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("reimbursement enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("interview panel enquiry")]
        public async Task InterviewPanelEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("interview panel enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("bond commencement enquiry")]
        public async Task BondCommenceEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("bond commencement enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("orientation attendance enquiry")]
        public async Task OrientationAttendanceEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("orientation attendance enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
        [LuisIntent("orientation training hours enquiry")]
        public async Task OrientationTrainingHoursEnquiry(IDialogContext context, LuisResult result)
        {
            List<ChatBotAnswer> possibleAns = cbaDAO.getChatBotAnswerByIntent("orientation training hours enquiry");

            if (possibleAns.Count > 0)
            {
                Random rdm = new Random();
                int r = rdm.Next(possibleAns.Count);
                await context.PostAsync($"{possibleAns[r].answer}");
            }
            else
            {
                await context.PostAsync($"I do not have the answer to your questions just yet.");
            }


            context.Wait(MessageReceived);
        }
    }
}