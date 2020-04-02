# Real-time chroma key filter
MATLAB implementation of accurate real-time histogram based chroma key filter.  

## Introduction
**Chroma key** compositing is a visual effects/post-production technique for compositing (layering) two images or video streams together based on colour hues (chroma range). The technique has been used in many fields to remove a background from the subject of a photo or video – particularly the newscasting, motion picture, and video game industries. A colour range in the foreground footage is made transparent, allowing separately filmed background footage or a static image to be inserted into the scene. The chroma keying technique is commonly used in video production and post-production.  
The aim of this code example is to extract the green background, also called chroma key, and replace it with the background from a different image. In fact what we're doing is keying out a black and white mask from the green component of the foreground image and using it to mask.  

