# AI-Assisted Development Process: Prompts Used

This document outlines the conversation and thought process used with an AI assistant to develop the data tiering solution for the Azure cost optimization challenge. The prompts are presented in a logical order, from initial brainstorming to final implementation details.

---

### **Prompt 1: Brainstorming a High-Level Fix**

*My initial thought process was about finding the right overall strategy. I knew I couldn't just delete the data, so I needed a way to move it somewhere cheaper.*

> "Hey, I've got this challenge with an Azure app. We're using Cosmos DB to store millions of billing records, and it's getting super expensive. The catch is, most of the data is old—older than three months—and nobody really looks at it. But, we still need to be able to pull it up within a few seconds if someone asks for it. I need a solid plan to slash these costs. The key constraints are zero data loss, no downtime for the users, and I absolutely cannot change the way our current API works. What's a good, simple strategy for this?"

---

### **Prompt 2: Designing the Architecture**

*Once I settled on the idea of data tiering, I needed to figure out exactly how the pieces would fit together. Which Azure services would I use and how would they talk to each other?*

> "Okay, I like the data tiering idea—using Cosmos DB for the 'hot' recent data and Azure Blob Storage for the 'cold' old data. Can you help me sketch out the architecture for this? I need to understand the complete data flow for three key scenarios:
> 1.  When a **new record is created**.
> 2.  When a user **requests a record** (it could be new or old).
> 3.  The **automatic background process** that moves the old records from Cosmos DB to Blob Storage.
>
> Could you describe it in a way that I can use to draw an architecture diagram?"

---

### **Prompt 3: Writing the Actual PowerShell Code**

*With the architecture planned, it was time to get into the code. I'm most comfortable with PowerShell, so I wanted to see what the core logic would look like in that language.*

> "Great, the design makes sense. Now, can you help me write the actual PowerShell code for the Azure Functions? I need three separate scripts:
> 1.  A script for an **HTTP trigger** that handles writing new records. It should just take the incoming request and dump it into Cosmos DB.
> 2.  A smarter **HTTP trigger** for reading records. It needs to check Cosmos DB first. If it doesn't find the record there, it should then go look in Blob Storage.
> 3.  A **Timer trigger** that runs once a day. This one needs to find all records in Cosmos DB older than 90 days, copy them over to Blob Storage, and—only after it's sure the copy worked—delete the original from Cosmos DB."

---

### **Prompt 4: Structuring the Project for Submission**

*To make this a professional submission, I needed to organize everything neatly in a GitHub repository.*

> "To wrap this up, I need to present the entire solution in a public GitHub repository. Can you walk me through the best way to structure the project? I'm thinking of creating folders like `api`, `functions`, and `docs`. Also, could you generate the text for a couple of Markdown files? I'll need a main `README.md` for the project root and a more detailed `solution_overview.md` inside the docs folder to explain the whole thing."

---

### **Prompt 5: Thinking About What Could Go Wrong (Risk Analysis)**

*The assignment specifically mentioned thinking about failure points. I wanted to show I was considering the real-world implications of this design.*

> "This all looks good, but the prompt asks me to 'go beyond the obvious.' So, let's think about what could break in a real production environment. Can you help me identify the main risks with this data tiering solution? For example, what happens if the archival job crashes halfway through? Or what if a user requests a record at the exact millisecond it's being moved? For each risk, let's brainstorm a solid mitigation strategy."
