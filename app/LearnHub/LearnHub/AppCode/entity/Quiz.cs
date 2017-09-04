using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Quiz
    {
        private int quizID;
        private Course_elearn mainCourse;
        private string title;
        private string description;
        private int passingGrade;
        private string status;
        private string randomOrder;
        private int timeLimit;
        private string multipleAttempts;
        private int numberOfAttempts;
        private string displayAnswer;

        public Quiz() { }
        public Quiz(int quizID, Course_elearn mainCourse, string title, string description, int passingGrade, string status, string randomOrder)
        {
            this.quizID = quizID;
            this.mainCourse = mainCourse;
            this.title = title;
            this.description = description;
            this.passingGrade = passingGrade;
            this.status = status;
            this.randomOrder = randomOrder;
        }
        public int getQuizID()
        {
            return quizID;
        }
        public void setQuizID(int quizID)
        {
            this.quizID = quizID;
        }
        public Course_elearn getMainCourse()
        {
            return mainCourse;
        }
        public void setMainCourse(Course_elearn mainCourse)
        {
            this.mainCourse = mainCourse;
        }
        public string getTitle()
        {
            return title;
        }
        public void setTitle(string title)
        {
            this.title = title;
        }
        public string getDescription()
        {
            return description;
        }
        public void setDescription(string description)
        {
            this.description = description;
        }
        public int getPassingGrade()
        {
            return passingGrade;
        }
        public void setPassingGrade(int passingGrade)
        {
            this.passingGrade = passingGrade;
        }
        public string getStatus()
        {
            return status;
        }
        public void setStatus(string status)
        {
            this.status = status;
        }
        public string getRandomOrder()
        {
            return randomOrder;
        }
        public void setRandomOrder(string randomOrder)
        {
            this.randomOrder = randomOrder;
        }
        public int getTimeLimit()
        {
            return timeLimit;
        }
        public void setTimeLimit(int timeLimit)
        {
            this.timeLimit = timeLimit;
        }
        public string getMultipleAttempts()
        {
            return multipleAttempts;
        }
        public void setMultipleAttempts(string multipleAttempts)
        {
            this.multipleAttempts = multipleAttempts;
        }
        public int getNumberOfAttempts()
        {
            return numberOfAttempts;
        }
        public void setNumberOfAttempts(int numberOfAttempts)
        {
            this.numberOfAttempts = numberOfAttempts;
        }
        public string getDisplayAnswer()
        {
            return displayAnswer;
        }
        public void setDisplayAnswer(string displayAnswer)
        {
            this.displayAnswer = displayAnswer;
        }
    }
}