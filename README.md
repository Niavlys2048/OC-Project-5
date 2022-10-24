# OpenClassroom - Project 5

General description:
- CountOnMe: Improve an existing application

Technical constraints:
- The code must:
    - Be commented correctly
    - Written in English
    - Respect the MVC pattern
    - Accompanied by complete unit tests
    - Allow the application to be displayed in all iPhone sizes in portrait mode.
    - Be free of any error or warning.
    - Be functional on iOS 11 and above and written in Swift 4 minimum.
    - The current algorithm should be preserved. The use of the expression NSExpression is not allowed.


Release notes:

dev-20221012:
- Setting up the MVC pattern
- Design improvement
- Code refactoring

dev-20221014:
- Using SwiftLint with a custom .swiftlint.yml file
- Responsive Design for all iPhone/iPad size in portrait and landscape mode
- Through Test-Driven Development:
    - Code refactoring
    - Added multiplication and division features
    - Added AC Button (All Clear)
    - Improved code to enable all features with given buttons (all cases) > No more alertVC/fatalError
- Unit/UI Tests passed (SimpleCalcTests cover 98,9% of the Model and SimpleCalcUITests cover 96,8% of the Controller)
- Changed iOS target from 12.2 to 11 as required

dev-20221015:
- Changed access control of Calculator class properties

dev-20221018:
- Replaced if by guard in func equal()
- Changed access control of ViewController Outlets and Actions
- Made TextView unselectable

dev-20221022:
- Sign button displayed and enabled (Enabled=true, Alpha=1, User Interaction Enabled)
- Replaced sign button text from "±" to "+/-" for better visibility and changed font size to accommodate new text
- Added signChange functionality (same behavior as the official Apple calculator) through TDD:
    - Added IBAction for the sign-change button
    - Created signChange() function and changed addNumber() function in Calculator

dev-20221023-15-15:
- Minor fix in signChange() function
- Support for operand priority (multiplication and division must take priority over addition and subtraction) through TDD:
    - Created computePriorityOperations()
    - Refactoring of the equal() function
    - Created formatWholeNumber() function for code reuse
- Result of a division by zero modified to be equal to "Error" as on the official Apple calculator, through TDD:
    - Changed equal() function to format error on division by zero
    - Created a computed property errorDivisionByZero
    - Changed addOperator() and signChange() functions to handle division by zero
    - Unit Tests for division by zero

dev-20221023-16-10:
- decimal-separator button displayed and enabled (Enabled=true, Alpha=1, User Interaction Enabled)
- Added decimal-separator functionality (same behavior as the official Apple calculator) through TDD:
    - Added IBAction for decimal-separator button
    - Create addDecimalSeparator() function in Calculator

dev-20221024-13-00:
- Created percent button and design improvement
- Added percent functionality (same behavior as the official Apple calculator) through TDD:
    - Added IBAction for percent button
    - Create getPercent() function in Calculator
- Created an extension for the Double type, for the needs related to the division and the maximum fraction digits (after decimal separator)
- Created a computeDivision() function to handle rare cases of wrong result when a Double is divided by 100 (or any multiple of 10)
- formatWholeNumber() and computePriorityOperations() functions refactoring
- Minor fix in equal() function


dev-20221024-14-55:
- Minor change in computePriorityOperations() and equal() functions
- Changed the access control of newly created IBActions
- Created a separate Double+Extension.swift file in a new folder named Helpers to handle the Double type extension
- Fixed test 6 result in SimpleCalcUITests
- Created a last Unit test for percent
- Included .swiftlint.yml file in git

dev-20221024-15-09:
- Minor fix in SimpleCalcTests class (by adding // swiftlint:disable type_body_length) to avoid unnecessary warnings

dev-20221024-18-58:
- Debugged computeDivision() function, to keep precise results in case of multiple of 10 starting with a number other than 1 (example: 200, ..., 900)
- Added a Unit Test to validate changes and check if there is no regression
