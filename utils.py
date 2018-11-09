import os
import matplotlib.image as plimage


def save_image(img, file_name):
    if not os.path.exists('tmp'):
        os.makedirs('tmp')
    plimage.imsave(os.path.join('tmp', file_name), img)
