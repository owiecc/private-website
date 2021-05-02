---
layout: article
title: Finding mapping errors with Overpass Turbo
author: Szymon Bęczkowski
category: maps
tags: [openstreetmap, mapping, basics]
---

(From Slack) Can you help me build a query for finding a poorly mapped bicycle/street crossings where the bicycle path is on top of a speed table for cars? Essentially I am looking for nodes that contains traffic_calming=* and are a part of highway=cycleway and at the same are a part of highway=!cycleway

[bbox:{{bbox}}];
way[highway=cycleway]->.a;
way[highway!=cycleway]->.b;
node(w.a)(w.b)[traffic_calming];
out;

What if a footpath joins a road?

What is a road joins another road? 