# Feedback dApp [work in progress] - README

**Feedback dApp** is a decentralized application (dApp) showcasing the management of brand's owner,brand's posts, and user's feedback using tokenized tokens. This README provides an overview of the main file and the functionalities it offers. Please note that this is a demonstration project, and the tokens used here are not transferable or real.

## Table of Contents
- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Functionality Overview](#functionality-overview)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Feedback dApp demonstrates how smart contracts can be used to handle brand registration, post creation, and user feedback in a decentralized manner. It leverages the [MOTOKO](https://sdk.dfinity.org/docs/language-guide/motoko.html) programming language and integrates essential functionalities for different user roles.

## Project Structure

The project consists of a single main file containing an actor with several shared and query functions, as well as private helper functions. Here's an overview of the main components:

- **Base Imports**: The initial section includes base imports for necessary modules such as Array, List, Iter, Principal, Error, and Time.

- **mops - map**: This section imports the Map module required for mapping data structures.

- **Type Definitions**: Here, various type definitions are provided for Brand, Post, User, Feedback, and other entities. Additionally, aliases for map types and query results are defined.

- **Variables**: The section declares stable variables, such as `brandCount`, `userCount`, `postCount`, and `feedbackCount`. These variables keep track of the total number of brands, users, posts, and feedbacks, respectively. Furthermore, stable maps like `brandMap`, `postMap`, `userMap`, and `feedbackMap` are initialized to store brand, post, user, and feedback data.

- **Actor Functions**: The actor defines several shared and query functions to handle various actions. These functions are categorized based on the roles of the caller (brand or user) and provide functionalities such as brand registration, post creation, user registration, feedback posting, and more.

- **Private Functions**: This section contains private helper functions utilized by the actor functions for data manipulation and updating brand and user information.

## Functionality Overview

The Feedback dApp offers the following key functionalities:

- **Brand Actions**: Brand owners can register their brand and create new posts with reward amounts. They can also query details about their brand, including open and closed posts.

- **User Actions**: Users can register themselves and provide feedback on posts. They can query details about their own feedback and posts they have contributed to.

- **Shared Actions**: Some actions are accessible to both brand owners and users. For example, both can register with the system, allowing them to participate accordingly.

## Contributing

We welcome contributions to improve and extend this example. If you would like to contribute, please fork the repository and submit a pull request with your proposed changes.

## License

This Feedback dApp is provided under the [MIT License](LICENSE), granting you the freedom to modify and distribute the code for your own purposes.

---

Thank you for checking out the Feedback dApp! If you have any questions or need further assistance, feel free to reach out. Happy coding!
