# Software Design Glossary for Interacting with Agentic AI (English)

This document compiles key software design terms explained in simple, accessible language for non-technical users. Its goal is to facilitate clear communication and collaborative design when working with autonomous AI systems (agentic AI).

---

## 1. System Architecture and Fundamentals

| Term | Technical Description | Typical Uses in AI Collaboration | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **Frontend** | The visual user interface of an application (buttons, text, menus, colors) that the user interacts with directly in the browser or mobile device. | Designing the look, feel, animations, and visual workflow of pages and screens. | *"Design the frontend for a medical registration form, ensuring it is clean, uses blue color tones, and is mobile-friendly."* |
| **Backend** | The behind-the-scenes logic ("the brain" of the system) that processes data, manages security, communicates with databases, and handles business rules. | Defining how data is saved, how user access is validated, and how the underlying software logic operates. | *"Build the backend to process the registration form, validating that the email address is not already registered before saving."* |
| **Database** | An organized, persistent system designed to store, query, and retrieve information safely and efficiently. | Defining where and how business records (users, products, sensor readings) will be stored. | *"Generate a relational database to manage a medical clinic, storing patients, appointments, and medical histories."* |
| **Server / Client** | The **Client** is the device requesting a service (e.g., your web browser), and the **Server** is the remote computer that processes and responds to that request. | Designing network or web architectures and defining resource loading/request flows. | *"Set up the client-server connection so that when the client clicks 'Search', the server returns the results in under a second."* |
| **Deployment / Production** | **Deployment** is the process of publishing software to the internet. **Production** is the live environment where end-users interact with the active application. | Moving from a draft/development phase to a public release available to everyone worldwide. | *"Prepare the application for deployment to a web server, and ensure that the production environment has SSL security enabled."* |

---

## 2. Data Modeling and Structuring

| Term | Technical Description | Typical Uses in AI Collaboration | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **Data Model / Entity** | A representation of a real-world concept (e.g., "Patient", "Product") structured as an object or table within the software. | Defining core business concepts and structuring the baseline data of the application. | *"Define the 'Course' entity with attributes for name, internal code, description, and start date."* |
| **Attribute / Field** | The specific characteristics or data points that describe an entity (e.g., the "Age" attribute of a "Patient" entity). | Detailing the exact information to be captured or displayed for each object in the system. | *"Add the attributes 'price', 'stock_available', and 'category' to the 'Product' entity."* |
| **Relationship & Hierarchy** | How entities connect to one another (e.g., a 1-to-Many relationship where a "Course" has multiple "Sections", or a Parent/Child relation where a section belongs to a course). | Creating structured databases, consistent relationships, and logical content trees. | *"Establish a hierarchy where 'Major' is the parent of 'Course', and 'Course' is the parent of 'Section'."* |
| **Primary Key / Foreign Key** | A **Primary Key** is the unique identifier of a record (e.g., a User ID). A **Foreign Key** is that same ID stored in another table to establish a link between the two. | Linking relational database tables to prevent confusion between similar records. | *"Configure the patient ID as a primary key in the 'Patients' table and as a foreign key in the 'Appointments' table to link them."* |
| **Enum / Catalog** | A closed list of predefined values that do not change frequently (e.g., days of the week, user roles like "Admin" or "Reader"). | Restricting user input to prevent typos and ensure data consistency across the database. | *"Create an Enum for the medical appointment status with fixed values: 'Pending', 'Confirmed', 'Cancelled', and 'Completed'."* |
| **JSON / YAML** | Structured, human-readable text formats used widely to exchange data between systems or write configuration settings. | Exchanging data between frontend and backend, or writing clean configuration files. | *"Return the patient details in JSON format so the frontend can easily display them in a table."* |

---

## 3. User Interface and UX (User Interface / User Experience)

| Term | Technical Description | Typical Uses in AI Collaboration | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **UI Event / Callback** | An action taken by a user on the screen that the system detects (e.g., `onClick` when clicking, `onChange` when typing in a text field). | Programming specific reactions when a user interacts with visual controls. | *"On the `onChange` event in the search box, filter the list of students in real-time without reloading the page."* |
| **Autosave vs. Manual Save** | **Autosave** persists changes in real-time based on small events (like losing focus on a field), whereas **Manual Save** requires clicking a "Save" button. | Designing the data persistence experience and ensuring the user does not lose progress. | *"Implement an autosave mechanism triggered by the `onBlur` event on all medical history fields."* |
| **UI State** | The temporary visual condition of a user interface element (e.g., `loading` while retrieving data, `disabled` when blocked, `error` if a field is invalid). | Providing visual feedback to users about what is happening internally in the application. | *"If required fields are empty, change the submit button state to `disabled` and outline the empty inputs in red."* |
| **Common UI Components** | Standard visual elements like **Modals** (pop-up dialogs), **Toasts** (temporary alert notifications), **Inputs** (text boxes), and **Selects** (dropdown lists). | Building a consistent user interface using a catalog of standard design elements. | *"Show a Toast notification in the top-right corner when changes are successfully saved."* |
| **Responsive Design** | A design approach that automatically adjusts the user interface to look good on any screen size (mobile, tablet, desktop). | Ensuring the application is fully usable across desktops, tablets, and phones alike. | *"Make the dashboard layout responsive, hiding the sidebar on mobile and replacing it with a hamburger menu."* |

---

## 4. Agentic AI Interactions and Development

| Term | Technical Description | Typical Uses in AI Collaboration | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **Agentic AI / Autonomous Agent** | AI systems designed to operate independently, make sequential decisions, use developer tools, and resolve complex issues without step-by-step approvals. | Delegating end-to-end development tasks (such as writing code, security audits, or unit testing). | *"Act as an autonomous software development agent and refactor this folder structure to make it more maintainable."* |
| **Execution Loop** | The iterative process where an AI agent analyzes a task, takes action (e.g., writes code), evaluates the output/error, and corrects its plan until successful. | Understanding how the AI debugs issues and advances past compilation errors or lints on its own. | *"Use your internal execution loop to run the build command, resolve any TypeScript errors, and repeat until the build succeeds."* |
| **Tool Calling / Tool Use** | An AI agent's capability to invoke external operations (e.g., reading/writing files, running terminal commands, searching the web) to complete a task. | Letting the AI directly modify the codebase or fetch real-time documentation updates. | *"Use your file-editing tool to locate where server routes are defined and add a new API endpoint."* |
| **Subagent** | A secondary, specialized AI agent created by the primary agent to execute a narrow task in isolation. | Dividing large projects into hyper-specialized subtasks run in parallel (e.g., one subagent for writing documentation and another for coding). | *"Spawn a subagent specialized in web accessibility (WCAG) to audit our UI components and suggest improvements."* |
| **Prompt / Prompt Engineering** | The structured input or instruction given to an AI to get the most accurate, contextual, and high-quality response. | Guiding the model's behavior by specifying roles, context, rules, and expected output formats. | *"Use prompt engineering by adding input/output examples (few-shot prompting) to structure the generated response."* |
| **Mock Data / Test Data** | Realistic, dummy data (e.g., fake names, emails, dates) generated to test application flows before connecting to live databases. | Safely testing frontend layouts or business logic without exposing or risking real user data. | *"Generate mock data representing 10 kinesiology students along with their scores for biomechanics."* |

---

## 5. Workflows and Git

| Term | Technical Description | Typical Uses in AI Collaboration | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **Repository** | A digital folder or directory managed by Git where all source code and its entire revision history are stored. | Organizing the project codebase and tracking historical changes over time. | *"Set up a new local repository and initialize a .gitignore file suitable for a Node.js project."* |
| **Git Commit / History** | A **Commit** is a snapshot of the codebase at a specific point in time, accompanied by a message explaining the changes made. | Incrementally saving software progress, making it easy to roll back changes if something breaks. | *"Commit the glossary changes with a descriptive message following Conventional Commits guidelines."* |
| **Refactoring** | Restructuring existing computer code to improve internal readability, efficiency, or structure without changing its external behavior. | Optimizing system performance or making code easier to maintain and extend in the future. | *"Refactor this function to remove duplicate logic and make it easier to write unit tests for."* |
| **Metadata / Frontmatter (YAML/Markdown)** | A block of structured metadata at the very beginning of a Markdown file (usually enclosed in `---` lines) used to classify documents. | Defining document properties (e.g., title, author, version) to be parsed by automatic file lists or web generators. | *"Add a YAML Frontmatter block to the top of this Markdown file specifying the author, language, and creation date."* |

---

## Web References to Learn More

To dive deeper into software design and development concepts, we recommend exploring:

1. **[MDN Web Docs (Mozilla Developer Network)](https://developer.mozilla.org)** - The ultimate, beginner-friendly resource for HTML, CSS, JavaScript, and general web design terminology.
2. **[Refactoring.Guru](https://refactoring.guru)** - An exceptionally visual site explaining software design patterns and refactoring using simple analogies.
3. **[The Agent Skills Directory](https://www.skills.sh)** - A registry of resources and specifications covering skill design and instructions for autonomous agents.
4. **[W3Schools](https://www.w3schools.com)** - Simple, interactive tutorials perfect for beginners looking to learn basic coding and technical terms.
