public static boolean routeForApproval(TNF tnf) {
  User user;
  ArrayList <User> users = new ArrayList<😠);
  String tnfType = “”;
  boolean gotBudget = false;
  
  //getting the type as individual or group
  if (tnf.getType() == “Individual”) {
    user = tnf.getUser();
    tnfType = “individual”;
  } else {
    users = tnf.getUsers();
    tnfType = “group”;
  }

  // check if not group then check individual duration, else check each individual in the group
  if (users.isEmpty()) {
    if (user.getDuration() < 3) {
      return false;
    }
  } else {
    for each user in users {
      // check duration for each user
      // return false if user’s duration is < 3 months
    }
  }

  //To check budget, variable checking is gotBudget

  if (gotBudget) {
    if (tnfType.equals(“individual”) {
      return routeIndividual(tnf);
    } else {
      return routeGroup(tnf);
    }  
  } else {
    updateTNFStatus(“Rejected. Department no budget”);
    return false;
  }
  
}

public static boolean routeIndividual(TNF tnf) {
  User currentUser = tnf.getUser();
  WfDAO wfDAO = new WfDAO();
  UserDAO userDAO = new UserDAO();
  Workflow currentWorkflow = wfDAO.getWF();
  int numOfCriteria = currentWorkflow.getCriteria();
  String currentStatusOfTNF = tnf.getStatus();
  ArrayList<WorkFlow_Route> workflowRoute = currentWorkFlow.getSortedWorkflowRoute(); //sorted by amt

  if (currentStatusOfTNF.equals(“Pending”) {
    for (int i  = 0; i < numOfCriteria; i++) {
      double low_limit = workflowRoute.getLowLimit();
      double high_limit = workflowRoute.getHighLimit();
      ArrayList<WorkFlow_Approvers> approvers = workflowRoute.getApprovers();
      if (tnf.getAmount() >= low_limit && tnf.getAmount() <= high_limit) {
        WorkFlow_Approver currentApprover = approvers.get(tnf.getWFStatus());
        User approver = userDAO.getUser(currentApprover.getID());
        // need to check if applicant is higher “level” than approver too
        if (currentUser != approver) {
          sendApprovalNotification(tnf, approver);
          return true;
        } else {
          //to do something if applicant is approver
        }
      } //end if check for amount within range
    } //end for loop of all workflow criteria

    //check bond criteria
    BondDAO bondDAO = new BondDAO();
    double bondCriteria = bondDAO.getBondCriteria();
    if (tnf.getAmount() >= bondCriteria) {
      //create new bond object
      return true;
    }

  } //end check for status of TNF is pending
  return false;
}

public boolean routeGroup(TNF tnf) {
  ArrayList<User> users = tnf.getUsers();
  ArrayList <Boolean> statuses = new ArrayList<😠);
  for each user in users {
    statuses.add(routeIndividual(tif, user);
  }

  if (statuses contains false) {
    updateTNFStatus(“Error in processing”);
    return false;
  } else {
    return true;
  }
}


For bond object creation

public Bond(TNF TNF) {
  //constructor to send notification to relevant approver based on amount
}