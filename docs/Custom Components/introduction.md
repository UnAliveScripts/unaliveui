# Creating Custom Components

UnAlive allows you to create and register custom components that follow the same API patterns as built-in components.

## Overview

Custom components in UnAlive are simple functions that receive the UnAlive instance and a properties table, then return a component table with `Type`, `Instance`, and any custom methods.

Components can access the current theme, icons, services, and utility modules through the UnAlive instance passed as the first argument.
