import pickle
import matplotlib.pyplot as plt
import numpy as np
import torch




def load_pickle(file_path):
    with open(file_path, 'rb') as handle:
        unserialized_data = pickle.load(handle)
    return np.array([t.detach().numpy() for t in unserialized_data]).flatten()

def draw_loss(loss_hist):
    plt.scatter(np.arange(len(loss_hist)), loss_hist)
    plt.show()



if __name__ == "__main__":
    loss_hist = load_pickle('loss_hist/loss_history_1100.pickle')
    print(max(loss_hist))
    draw_loss(loss_hist)
