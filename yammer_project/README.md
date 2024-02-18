# [Yammer Investigating a Drop in User Engagement](https://mode.com/sql-tutorial/a-drop-in-user-engagement)
분석보고서 <https://0shin.notion.site/Yammer-drop-user-engagement-interactive-chart-981d90413c5c4ff4aef0063bf8da3f93?pvs=4>
## Problem
특정일 이후로 WAU가 감소 -> WAU 감소에 대한 원인 파악
## Engagement의 정의
the number of users who logged at least one engagement event during the week starting on that date
## 테이블 정보
- 데이터는 Fake Data로 데이터크기 문제로 100개의 Row만 출력 가능
- Table1 : Users
 ```
       user_id: A unique ID per user. Can be joined to user_id in either of the other tables.

    created_at: The time the user was created (first signed up)
  
         state: The state of the user (active or pending)
  
  activated_at: The time the user was activated, if they are active
  
    company_id: The ID of the user's company
  
      language: The chosen language of the user 
 ```
- Table2 : Events
```
    user_id: The ID of the user logging the event. Can be joined to user_id in either of the other tables.

occurred_at: The time the event occurred.

 event_type: The general event type. There are two values in this dataset: "signup_flow", which refers to anything occuring during the process of a user's authentication, and "engagement", which refers to general product usage after the user has signed up for the first time.

 event_name: The specific action the user took. Possible values include: create_user: User is added to Yammer's database during signup process enter_email: User begins the signup process by entering her email address enter_info: User enters her name and personal information during signup process complete_signup: User completes the entire signup/authentication process home_page: User loads the home page like_message: User likes another user's message login: User logs into Yammer search_autocomplete: User selects a search result from the autocomplete list search_run: User runs a search query and is taken to the search results page search_click_result_X: User clicks search result X on the results page, where X is a number from 1 through 10. send_message: User posts a message view_inbox: User views messages in her inbox

   location: The country from which the event was logged (collected through IP address).

     device: The type of device used to log the event.
```
- Table3 : Email Events
```
    user_id: The ID of the user to whom the event relates. Can be joined to user_id in either of the other tables.

occurred_at: The time the event occurred.

     action: The name of the event that occurred. "sent_weekly_digest" means that the user was delivered a digest email showing relevant conversations from the previous day. "email_open" means that the user opened the email. "email_clickthrough" means that the user clicked a link in the email.
```
