<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>

<%
    int ManCount = 0;
    int WomanCount = 0;
    int count = 0;
    int DepositCount = 0; // Corrected variable name
    int WithdrawlCount = 0;
    int DemandDraftCount = 0;
    Random random = new Random();
    String countParam = request.getParameter("count");
    if (countParam != null && !countParam.isEmpty()) {
        count = Integer.parseInt(countParam);
    }
    count++;
    ArrayList<String> GenderList = new ArrayList<>();
    GenderList.add("Man");
    GenderList.add("Woman");
    ArrayList<String> What = new ArrayList<>(); // Correct declaration here
    What.add("Withdrawl");
    What.add("Deposit");
    What.add("DemadDraft");
    ArrayList<String> Whatt = (ArrayList<String>) session.getAttribute("Whatt"); // Retrieve existing Whatt ArrayList
    if (Whatt == null) {
        Whatt = new ArrayList<>();
    }
    String selectedWhat = What.get(random.nextInt(What.size()));
    Whatt.add(selectedWhat); // Add one random value to Whatt ArrayList
    session.setAttribute("Whatt", Whatt); // Store updated Whatt ArrayList in session

    String selectedGender = GenderList.get(random.nextInt(GenderList.size()));
    ArrayList<String> AtCounter = (ArrayList<String>) session.getAttribute("AtCounter");
    if (AtCounter == null) {
        AtCounter = new ArrayList<>();
    }
    AtCounter.add(selectedGender);
    session.setAttribute("AtCounter", AtCounter);
    int totalTime = 0;
    for (String gender : AtCounter) {
        int randomTime = random.nextInt(30) + 1;
        totalTime += randomTime;
        if (gender.equals("Man")) {
            ManCount++;
        } else if (gender.equals("Woman")) {
            WomanCount++;
        }
    }
    for (String what : Whatt) { // Changed variable name to avoid confusion
        if (what.equals("Deposit")) { // Corrected variable name
            DepositCount++; // Corrected variable name
        } else if (what.equals("Withdrawl")) {
            WithdrawlCount++;
        } else if (what.equals("DemadDraft")) { // Corrected typo in transaction type
            DemandDraftCount++;
        }
    }
    String largestType;
    int largestCount;
    if (DepositCount > WithdrawlCount && DepositCount > DemandDraftCount) {
        largestType = "Deposit";
        largestCount = DepositCount;
    } else if (WithdrawlCount > DepositCount && WithdrawlCount > DemandDraftCount) {
        largestType = "Withdrawl";
        largestCount = WithdrawlCount;
    } else {
        largestType = "DemandDraft";
        largestCount = DemandDraftCount;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank</title>
</head>
<body>
    <h1>Bank</h1>
    <% if (count < 10) { %>
        <form action="process.jsp" method="get">
            <input type="hidden" name="count" value="<%= count %>">
            <button type="submit">Go</button>
        </form>
    <% } else { %>
        <h2>Total Time: <%= totalTime %> minutes</h2>
        <h2>Number of Men: <%= ManCount %></h2>
        <h2>Number of Women: <%= WomanCount %></h2>
        <h2>Number of people at Deposit: <%= DepositCount %></h2>
        <h2>Number of people at Withdrawl: <%= WithdrawlCount %></h2>
        <h2>Number of DemandDraft: <%= DemandDraftCount %></h2>
        <h2>There is maximum people at: <%= largestType%></h2>
    <% } %>
</body>
</html>
