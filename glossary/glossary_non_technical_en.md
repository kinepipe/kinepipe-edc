# Expanded Software Design Glossary for Interacting with Agentic AI (English)

This document compiles key terms from frontend development, user interfaces (UI), data modeling, hierarchical logic, and persistence. Its purpose is to help non-technical users communicate with precision when collaborating with autonomous AI systems (agentic AI) to design and refactor software.

---

## Table of Contents
1. [UI Events & Callbacks](#1-ui-events--callbacks)
2. [UI States](#2-ui-states)
3. [Dynamic Naming & Variable Formatting](#3-dynamic-naming--variable-formatting)
4. [Data Structure, Hierarchies & Nesting](#4-data-structure-hierarchies--nesting)
5. [Data Models & Catalogs](#5-data-models--catalogs)
6. [Persistence & Saving Workflows](#6-persistence--saving-workflows)
7. [Web References to Learn More](#web-references-to-learn-more)

---

## 1. UI Events & Callbacks

Events are actions taken by a user or triggered by the system that the browser detects. Defining which event triggers an action is key to programming interactive interfaces.

### A. Mouse (Pointer) Events
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`onClick`** | Occurs when the user clicks once on an element. | Submit buttons, links, save buttons. | *"Make it so that when the `onClick` event of the 'Submit' button triggers, it validates the whole form."* |
| **`onDoubleClick`** | Occurs when the user clicks rapidly twice on an element. | Opening folders, selecting words, advanced settings. | *"Configure an action so that on the `onDoubleClick` event over the student row, their complete history opens."* |
| **`onMouseEnter`** | Triggers the instant the mouse cursor enters the physical area of the element. | Showing dropdown menus, informational tooltips, or immediate hover visual effects. | *"When `onMouseEnter` triggers over the help icon, display a floating tooltip containing the explanatory text."* |
| **`onMouseLeave`** | Triggers the instant the mouse cursor leaves the area of the element. | Hiding tooltips, closing dropdown menus that were opened via hover. | *"When the `onMouseLeave` event triggers on the user menu, hide the dropdown smoothly."* |
| **`onMouseOver`** | Similar to `onMouseEnter`, but triggers repeatedly when the cursor moves over the element or any of its child elements. | Handling complex animations or multi-level nested menus. | *"Use `onMouseOver` on the list to highlight the specific section the user is currently hovering over."* |
| **`onMouseMove`** | Triggers continuously while the mouse cursor is moving within the boundaries of the element. | Interactive canvases, custom dragging indicators, tracking coordinates. | *"Capture the `onMouseMove` event to move a floating visual element following the cursor's coordinates."* |
| **`onContextMenu`** | Occurs when the user right-clicks on the element, before the default browser menu appears. | Opening custom context menus or disabling right-clicks during online exams. | *"Use the `onContextMenu` event to open a pop-up menu with 'Edit', 'Duplicate', and 'Delete' options."* |
| **`hover` (CSS)** | A visual state applied automatically in stylesheets while the cursor resides over the element. | Changing button colors or highlighting rows when hovering over them. | *"Apply a CSS `hover` effect on the buttons so that their background turns a darker blue when hovered."* |

### B. Keyboard Events
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`onKeyDown`** | Occurs the moment the user presses any key down on the keyboard. | Keyboard shortcuts (like pressing Esc to close a window), web game controls. | *"Listen for the `onKeyDown` event, and if the pressed key is 'Escape', close the active modal."* |
| **`onKeyUp`** | Occurs the moment the user releases a key they were pressing. | Validating input fields while typing, detecting typing completion. | *"Use `onKeyUp` in the input field to verify if the entered text matches a valid email format."* |
| **`onInput`** | Triggers in real-time every time a change is made to the value of a text input or textarea. | Live character counters, instant autocomplete searches. | *"Use `onInput` in the search bar to filter results with every letter the user types."* |
| **`onChange`** | Triggers when the element loses focus (blur) after its value has changed, or immediately upon selecting a different option in a dropdown (Select). | Saving data when the user finishes writing, capturing dropdown menu selections. | *"On the `onChange` event of the country select menu, update the list of available cities."* |

### C. Touch Events
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`onTouchStart`** | Occurs when the user places a finger on the touch screen. | Detecting the start of gestures on mobile devices, mobile games. | *"When `onTouchStart` fires, register the initial finger position to calculate the swipe distance."* |
| **`onTouchEnd`** | Occurs when the user lifts their finger off the touch screen. | Confirming actions in mobile interfaces, triggering quick taps. | *"On mobile devices, use `onTouchEnd` instead of click to speed up button responsiveness."* |
| **`onTouchMove`** | Triggers continuously as the user drags their finger across the screen. | Moving image carousels, dragging elements on mobile screens. | *"Capture the movement with `onTouchMove` to allow the user to slide the carousel slides with their finger."* |
| **`onTap`** | A touch abstraction representing a quick, simple tap on the screen (equivalent to a mouse click). | Common actions in mobile-friendly user interfaces. | *"Make the button respond to the `onTap` event on touch screens to bypass the delay of traditional clicks."* |
| **`onLongPress`** | An abstraction detecting when a finger is held down in the same place for a specified duration (e.g., 1 second). | Opening contextual menus or activating edit modes on mobile devices. | *"If the user performs a `onLongPress` on a question on mobile, activate the drag-to-reorder mode."* |

### D. Complex Interactions (Drag & Swipe)
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`drag`** | An event that fires continuously as an element is being dragged by the user. | Displaying the trajectory of an object during movement. | *"Show a diffuse shadow underneath the element for the duration of the `drag` event."* |
| **`dragstart`** | Fires the exact moment the user starts dragging an element. | Changing the look of the object (making it semi-transparent) to indicate it is selected for movement. | *"On the `dragstart` event, reduce the element's opacity to 50% to give visual drag feedback."* |
| **`dragend`** | Fires when the user finishes dragging (releasing the mouse button or lifting the finger). | Restoring the element's original appearance or clearing temporary variables. | *"On the `dragend` event, restore the object's opacity back to its original state."* |
| **`drop`** | Occurs when the dragged element is released over a valid target drop zone. | Processing uploaded files, placing an item in a new list position. | *"Capture the `drop` event on the upload zone to parse the PDF file dragged in by the user."* |
| **`drag & drop`** | The complete sequence composed of selecting an object, dragging it, and releasing it into a target container. | Matching column exercises, organizing task boards (Kanban). | *"Create an interactive `drag & drop` activity to match anatomical terms with their corresponding images."* |
| **`swipe`** | A quick touch gesture sliding the finger in a specific direction (left, right, up, down). | Turning pages in digital books, dismissing pop-up notifications. | *"Implement a left `swipe` gesture to delete a student from the attendance list."* |
| **`pinch`** | A multi-touch gesture detecting when two fingers move closer together or further apart on the screen. | Interactive zooming over diagrams, medical images, or maps. | *"Allow the `pinch` gesture on the image viewer to zoom in and out of the sample X-ray."* |

### E. Focus and Navigation Events
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`onFocus`** | Fires when an interactive element (like an input or button) receives cursor or keyboard selection focus. | Highlighting the active field, displaying contextual help text. | *"When `onFocus` triggers on the 'Password' field, display a popup box showing the security requirements."* |
| **`onBlur`** | Fires when an interactive element loses selection focus (the user clicks elsewhere or tabs away). | Validating field emptiness, formatting text (e.g. converting to uppercase), or triggering autosaves. | *"On the `onBlur` event of the DNI/ID field, validate if the formatting is correct and show an error if it isn't."* |
| **`onSelect`** | Occurs when the user selects text inside an input field or textarea. | Quick text copying, displaying text formatting menus (bold, italic) in text editors. | *"Use `onSelect` in the PDF reader to allow the user to highlight and mark key terms."* |
| **`onSubmit`** | Fires when a form is submitted (by clicking a submit button or pressing Enter). | Sending answers to a server, validating all fields together before processing. | *"Prevent the default behavior on the `onSubmit` event of the form and send the data via an asynchronous request."* |
| **`onReset`** | Occurs when the user resets a form by clicking a reset button. | Returning search box fields back to their default values. | *"On the `onReset` event, clear the search results currently displayed on the screen as well."* |

### F. Load & Window State Events
| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`onLoad`** | Triggers when the browser has finished loading the element or page fully (including images and stylesheets). | Hiding loading screen spinners, launching entry animations, initializing user data. | *"When the application's `onLoad` event fires, request the assigned course details for the logged-in teacher."* |
| **`onUnload`** | Occurs when the user closes the tab or navigates away to another page. | Cleaning up temporary credentials, registering quick logout logs. | *"Use `onUnload` to send a metric to the server indicating the user closed the exam tab."* |
| **`onBeforeUnload`** | Triggers just before the page unloads or closes. Allows displaying a confirmation dialog. | Preventing users from losing unsaved changes or answers by closing the browser accidentally. | *"If there are unsaved changes in the exam editor, use `onBeforeUnload` to warn the user before they leave."* |
| **`onResize`** | Occurs when the browser window changes size or changes orientation (portrait/landscape on tablets). | Recalculating interactive graph dimensions, adjusting complex elements that don't support fluid CSS. | *"Listen for the window's `onResize` event to redraw the interactive canvas with its new proportions."* |
| **`onScroll`** | Fires continuously as the user scrolls up, down, or sideways on the page. | Creating reading progress indicators, 'back to top' buttons, or infinite scroll layouts. | *"On the `onScroll` event, calculate the percentage read of the lesson and update the top progress bar."* |

---

## 2. UI States

States represent the condition of an interface component at any given time. They help users understand what actions they can or cannot perform.

| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`active`** | Represents the visual state of an element while it is being pressed down (e.g., clicking a button before releasing it). | Providing immediate tactile feedback to user actions. | *"Change the button background to a light green color in its `active` state."* |
| **`disabled`** | Indicates that an element is disabled and will not respond to mouse or keyboard interactions (looks greyed out). | Blocking submit buttons if required inputs are missing, or freezing forms once submitted. | *"Keep the submit exam button in a `disabled` state until the student has answered at least 80% of the questions."* |
| **`selected`** | Indicates that an element or row has been explicitly chosen from a group of options. | Highlighting a table row or a selected answer alternative. | *"When the student clicks an alternative, apply the `selected` state with a 2px blue border."* |
| **`checked`** | A selection state specific to casements of type Checkbox or Radio Button. | Determining if a true/false or multi-select option is ticked. | *"Check if the 'Accept terms' checkbox has the `checked` state before permitting registration."* |
| **`focused`** | Indicates that a text input element is active and ready to receive keyboard entries. | Highlighting the text box borders to indicate active writing focus for accessibility. | *"When an input gains the `focused` state, increase the border contrast to comply with accessibility rules."* |
| **`loading`** | A temporary state indicating that a component is waiting for a background server process to complete. | Showing a spinning wheel (spinner) inside a button while validating credentials. | *"While the backend processes the login, put the button into a `loading` state and display an animated spinner."* |
| **`error`** | A visual state highlighting that an element contains incorrect data or has failed a validation rule. | Marking fields in red and showing warning messages underneath. | *"If the entered email is invalid, put the input in an `error` state and display 'Incorrect Email' in red below it."* |

---

## 3. Dynamic Naming & Variable Formatting

Useful for automating the creation of file names, student IDs, or dynamic text strings by combining database data fields.

| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`placeholder`** | A temporary text value serving as a locator until real data is supplied (e.g., `{user_name}`). | Designing certificate templates or automated messages. | *"Use `{course_name}` as a `placeholder` that dynamically resolves to the selected course name."* |
| **`template`** | A base string configured with fixed locators determining how text information will be merged. | Establishing uniform patterns for report filenames or automated exports. | *"Create a `template` to generate report names following this structure: `{date}-{course_code}-{report_type}`."* |
| **`concatenation`** | The process of joining two or more text strings together into a single string. | Joining student names and surnames, or building dynamic URLs. | *"Do a `concatenation` of the surname, a comma, a space, and the first name to display in the list."* |
| **`separator`** | The character placed between concatenated text elements to improve readability (e.g., `-`, `_`, ` \| `). | Organizing exported filenames clearly. | *"Use an underscore `_` as a `separator` to construct the generated PDF filename."* |
| **`delimiter`** | A character separating fields in flat files, enabling systems to know where one data point ends and the next begins. | Generating CSV export files structured with commas or semicolons. | *"Export the grade list using a semicolon `;` as the column `delimiter`."* |
| **`pattern`** | A strict validation rule or template defining the mandatory structure of a text string (e.g., regular expressions). | Validating course codes (e.g., 3 letters followed by 3 numbers: `KIN301`). | *"Establish a `pattern` requiring the section code to begin with a capital letter and end with a number."* |
| **`format`** | Modifying text output to normalize how it looks (e.g. uppercase, lowercase, removing accents). | Avoiding compatibility issues in folder structures and databases. | *"Apply a capital-case `format` so that all username inputs are saved with the first letter of each word capitalized."* |
| **User Attributes** | Predefined variables containing active user data (e.g. `{user_name}`, `{first_name}`, `{last_name}`, `{role}`, `{country}`, `{institution}`, `{course}`, `{date}`, `{id}`). | Personalizing user interfaces or creating directed automated reports. | *"Generate a personalized welcome screen displaying the `{first_name}` and `{role}` attributes of the logged-in user."* |
| **`fallback`** | A backup value or action triggered if the primary variable is empty or unavailable. | Avoiding blank screens or errors if secondary details are missing. | *"If the teacher hasn't uploaded a profile picture, use a generic user avatar as a `fallback`."* |
| **`slugify`** | The process of converting a text string into a URL-friendly format (lowercase, removing special characters/accents, spaces to hyphens). | Generating secure web addresses or automated file paths. | *"Apply `slugify` to the lesson title to generate its URL. Example: 'Intro to Biomechanics' should yield 'intro-to-biomechanics'."* |

---

## 4. Data Structure, Hierarchies & Nesting

Understanding how information levels are organized is key for the AI to design logical databases and consistent navigation trees.

```text
Typical Hierarchical Structure:
Major (Parent)
 └── Course (Child / Nested)
      └── Section (Child of Course / Nested)
           └── Teacher (Associated / Aggregation)
```

| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`parent`** | The superior level or entity containing or controlling dependent entities. | Structuring hierarchical menus or database keys. | *"Define the 'Faculty' entity as the `parent` of the 'Major' entity."* |
| **`child`** | A subordinate entity or element that directly depends on a superior or parent element. | Automatically deleting dependent elements if the parent is removed. | *"If a Course is deleted, make sure to cascade-delete all Sections that are its `child`."* |
| **`nested`** | Indicates that an object or component is placed inside the body of another data object or interface container. | Structured JSON trees or visual accordion menus. | *"Return a JSON structure where student grades are `nested` within each Section."* |
| **`hierarchy`** | The overall structure organized by levels of importance, ownership, or containment. | Modeling software architecture. | *"Create a three-level `hierarchy` for the school system: Institution -> Course -> Evaluations."* |
| **`relationship`** | A logical association established between two or more database tables or entities. | Connecting data (e.g., matching which students belong to which section). | *"Establish a many-to-many `relationship` between students and elective courses."* |
| **`composition`** | A strong ownership relation where the child element cannot exist without its parent (e.g., a Question is part of a specific Exam). | Designing strict databases and cascade deletes. | *"Use a `composition` relationship for sections: if the course is deleted, the sections must disappear entirely."* |
| **`aggregation`** | A weak association relation where the child element can exist independently even if its parent is removed (e.g., a Teacher assigned to a Course). | Allocating reusable resources. | *"The teacher relates to the course via `aggregation`: if the course is deleted, the teacher's profile must remain intact."* |

---

## 5. Data Models & Catalogs

Catalogs and definition types determine who holds permission to modify or add options within the system.

| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`enumeration` (Enum)** | A static, predefined list of mutually exclusive values written directly into the source code. | System states, user roles, days of the week. | *"Use an `enumeration` to define the question type: 'MultipleChoice', 'Essay', and 'TrueFalse'."* |
| **`system_defined`** | Fixed values configured from system build time that the end-user cannot edit or delete. | System parameters, standard country codes. | *"The institution type list must be `system_defined` to maintain consistency in government reporting."* |
| **`user_defined`** | Fields or values created completely at the discretion of the end-user. | Question search tags created by teachers, task names. | *"Allow exam topic tags to be freely created by teachers in a `user_defined` format."* |
| **`system_defined_editable`** | A catalog pre-populated with default system values that the user has permission to modify, expand, or delete. | Preconfigured grade scales, default cognitive skill taxonomies. | *"Design the cognitive taxonomy catalog as a `system_defined_editable` list so each school can adapt terms if they wish."* |
| **`derived`** | Data calculated dynamically in real-time from other existing values, without being stored permanently in the database. | Calculating final grades by averaging evaluations, calculating age from a birth date. | *"The 'Attendance Average' field must be a `derived` attribute calculated on-the-fly by summing monthly signatures."* |

---

## 6. Persistence & Saving Workflows

Determines how, when, and where user data is saved to the database to prevent loss of information.

| Term | Technical Description | Typical Use in UI / LMS | Example Prompt for the AI |
| :--- | :--- | :--- | :--- |
| **`autosave`** | A mechanism saving changes automatically in the background on specific events (like `onBlur` or timer intervals) without user block. | Online text editors, long evaluation forms. | *"Implement an `autosave` timer that saves the exam responses automatically every 60 seconds."* |
| **`manual_save`** | A mechanism requiring the user to explicitly click a control (like a 'Save' button) to store data. | Sending transactions, final exam submissions. | *"Use a `manual_save` workflow for exam submission, prompting a double confirmation dialog to the student."* |
| **`draft_state`** | A temporary state indicating that a document is in draft mode and its changes are not yet published or finalized. | Question drafting, exam preparation by teachers. | *"Allow saving questions in a `draft_state` so the teacher can edit them later before pushing them to the bank."* |
| **`persistence`** | The property of data to survive over time, remaining stably stored after shutting down the app or device. | Storing user profiles, historical grades, and system settings. | *"Ensure data `persistence` by saving the visual theme settings inside the browser's LocalStorage."* |
| **`import`** | Reading an external file (Excel, CSV, JSON) and incorporating its rows/data into the app database. | Bulk student roster uploads, loading question banks from external files. | *"Design an `import` interface that reads an Excel sheet and automatically registers the section's student roster."* |
| **`export`** | Extracting data from the system and formatting it into a downloadable file (PDF, Excel, JSON) for external use. | Generating downloadable grade sheets, backing up question banks. | *"Create a button to `export` the entire question bank into a structured JSON file."* |

---

## Web References to Learn More

To dive deeper into the technical standards governing interactive software design and educational system architectures, we recommend exploring the following sites:

1. **[MDN Web Docs (Mozilla Developer Network)](https://developer.mozilla.org)** - Excellent starting point for studying events, states, and web interactions with comprehensive guides and live code previews.
2. **[Refactoring.Guru](https://refactoring.guru)** - An exceptionally visual and illustrated portal explaining software architecture patterns and clean refactoring concepts.
3. **[The Agent Skills Directory](https://www.skills.sh)** - Centralized registry for agent skills specifications and guidelines.
4. **[W3Schools UI Design Tutorial](https://www.w3schools.com)** - Highly accessible interactive tutorials to get started with page layouts and web interface events.
5. **[ECC Tools - Harness Automation](https://ecc.tools)** - Documentation on open automated testing and security harnesses for AI agents in shared code environments.
