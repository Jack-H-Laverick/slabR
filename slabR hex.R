library(rayrender)
library(tidyverse)

data.frame(radius = seq(0.1, 0.5, length.out = 30),
           blend = seq(0.5, 0, length.out = 30),
           still = 1:30) %>% 
#   .[1,] %>% 
   pmap(function(radius, blend, still){

tictoc::tic()

scene <- sphere(x = -1, y = -1, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5) %>% 
  add_object(sphere(x = 0, y = -1, z = - 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = -1, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = 0, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = 0, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = 0, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = 1, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = 1, z = -1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = 1, z = -1, material = glossy(color = "#2b6eff", gloss = 1, reflectance = 0.05), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = -1, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = -1, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = -1, z = 0, material = glossy(color = "grey", gloss = 1), radius = radius)) %>%   # Sphere to shrink away
  add_object(sphere(x = -1, y = 0, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = 0, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = 0, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = 1, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = 1, z = 0, material = glossy(color = "grey", gloss = 1), radius = radius)) %>%   # Sphere to shrink away
  add_object(sphere(x = 1, y = 1, z = 0, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = -1, z = 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = -1, z = 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = -1, z = 1, material = glossy(color = "grey", gloss = 1), radius = radius)) %>%   # Sphere to shrink away
  add_object(sphere(x = -1, y = 0, z = 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 0, y = 0, z = 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = 1, y = 0, z = 1, material = glossy(color = "grey", gloss = 1), radius = 0.5)) %>%
  add_object(sphere(x = -1, y = 1, z = 1, radius = 0.5, material = glossy(color = "grey", gloss = 1))) %>% 
  add_object(sphere(x = 0, y = 1, z = 1, radius = 0.5, material = glossy(color = "grey", gloss = 1))) %>%  
  add_object(sphere(x = 1, y = 1, z = 1, radius = 0.5, material = glossy(color = "grey", gloss = 1))) %>%
  ## Overlay merging spheres
  add_object(csg_object(
    csg_combine(csg_combine(csg_combine(csg_combine(
      csg_sphere(x = -1, y = 1, z = 1, radius = 0.5),
      csg_sphere(x = 0, y = 1, z = 1, radius = 0.5), operation = "blend", radius = blend),
      csg_sphere(x = 1, y = 1, z = 1, radius = 0.5), operation = "blend", radius = blend), 
      csg_sphere(x = 1, y = 1, z = 0, radius = 0.5), operation = "blend", radius = blend), 
      csg_sphere(x = 1, y = 0, z = 1, radius = 0.5), operation = "blend", radius = blend), 
    material = glossy(color = "grey", gloss = 1))) %>%
  add_object(csg_object(
    csg_combine(csg_combine(csg_combine(
      csg_sphere(x = -1, y = -1, z = 1, radius = 0.5),
      csg_sphere(x = 0, y = -1, z = 1, radius = 0.5), operation = "blend", radius = blend),
      csg_sphere(x = -1, y = 0, z = 1, radius = 0.5), operation = "blend", radius = blend),
      csg_sphere(x = 0, y = 0, z = 1, radius = 0.5), operation = "blend", radius = blend),
    material = glossy(color = "grey", gloss = 1))) %>%
  add_object(csg_object(
    csg_combine(csg_combine(
      csg_sphere(x = 1, y = -1, z = -1, radius = 0.5),
      csg_sphere(x = 1, y = 0, z = -1, radius = 0.5), operation = "blend", radius = blend),
      csg_sphere(x = 1, y = 0, z = 0, radius = 0.5), operation = "blend", radius = blend),
    material = glossy(color = "grey", gloss = 1))) %>%
  add_object(csg_object(
    csg_combine(csg_combine(csg_combine(
      csg_sphere(x = -1, y = 1, z = 0, radius = 0.5),
      csg_sphere(x = -1, y = 1, z = -1, radius = 0.5), operation = "blend", radius = blend),
      csg_sphere(x = 0, y = 1, z = -1, radius = 0.5), operation = "blend", radius = blend), 
      csg_sphere(x = -1, y = 0, z = -1, radius = 0.5), operation = "blend", radius = blend),
    material = glossy(color = "grey", gloss = 1))) %>%
  ## Add text label ##
  add_object(text3d("s", x = -0.7, y = 1.35, z = 1.5, material=diffuse(color="#2b6eff"), 
                    text_height = 1, angle = c(25,0,-20))) %>% 
  add_object(text3d("l", x = 0.3, y = 1.3, z = 1.5, material=diffuse(color="#2b6eff"), 
                    text_height = 1, angle = c(25,0,-20))) %>% 
  add_object(text3d("a", x =1.35, y = 1.35, z = 1.35, material=diffuse(color="#2b6eff"), 
                    text_height = 1, angle = c(25,45,0))) %>% 
  add_object(text3d("b", x =1.46, y = 1.3, z = 0.2, material=diffuse(color="#2b6eff"),   #"grey10" 
                    text_height = 1, angle = c(40,90,30))) %>% 
  add_object(obj_model(r_obj(), x = 1.35, z = -0.7, y= 1.02, scale_obj = 0.3, angle = c(25,45,0), 
                       material=diffuse())) 

## PREVIEW size
# render_preview(scene, lookfrom = c(8,8,8), parallel = T,
#                backgroundhigh = '#ffffff', width = 640, height = 640, 
#                filename = str_glue("./frames/{still}.pr.png"))

## README size
# render_scene(scene, lookfrom = c(8,8,8), parallel = T, sample_method = "stratified",
#              samples = 3000,min_variance = 0, backgroundhigh = '#ffffff', clamp_value = 10,
#              width = 200, height = 200, filename = str_glue("./frames/{still}.200.png"))

## GITHUB social
render_scene(scene, lookfrom = c(8,8,8), parallel = T, sample_method = "stratified",
             samples = 2000,min_variance = 0, backgroundhigh = '#ffffff', clamp_value = 10,
             width = 640, height = 640, filename = str_glue("./frames/{still}.640.png"))

usethis::ui_done(str_glue("rendered frame {still}. {tictoc::tic()}"))

gc()
})

 
#gifski::gifski(glue::glue("./frames/{c(rep(1, 30), 2:29, rep(30, 30), 29:2)}.pr.png"), height = 200, width = 200, 
#               gif_file = "preview.gif", delay = 1/30)
 
#gifski::gifski(glue::glue("./frames/{c(rep(1, 30), 2:29, rep(30, 30), 29:2)}.200.png"), height = 200, width = 200, 
#               gif_file = "README.gif", delay = 1/30)

gifski::gifski(glue::glue("./frames/{c(rep(1, 30), 2:29, rep(30, 30), 29:2)}.640.png"), height = 640, width = 640, 
               gif_file = "github.gif", delay = 1/30)
