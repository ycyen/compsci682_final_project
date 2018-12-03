import pickle
import matplotlib.pyplot as plt
import numpy as np
import torch
import argparse
import sys
import os

parser = argparse.ArgumentParser()
parser.add_argument('--dir', required=True, help="directory of folder")




def load_pickle(file_path):
    with open(file_path, 'rb') as handle:
        unserialized_data = pickle.load(handle)
    return np.array(unserialized_data).flatten()

def merge(np1, np2, file_name): # merge two numpy array
    print(np1.shape, np2.shape)
    file = np.concatenate((np1, np2))
    print(file.shape)
    with open(file_name, 'wb') as handle:
        pickle.dump(file, handle)


def draw_loss(dir):
    loss_hist = load_pickle(dir)

    plt.scatter(np.arange(len(loss_hist)), loss_hist)
    plt.xlabel("iteration")
    plt.ylabel("loss")
    plt.show()

def draw_loss_together(dir):
    loss1 = load_pickle(dir + 'experiment1/loss_history.pickle')
    loss3 = load_pickle(dir + 'experiment3/loss_history.pickle')
    loss4 = load_pickle(dir + 'experiment4/loss_history.pickle')

    plt.scatter(np.arange(len(loss1)), loss1, label='exp1', s = 10)
    plt.scatter(np.arange(len(loss3)), loss3, label='exp3', s = 10)
    plt.scatter(np.arange(len(loss4)), loss4, label='exp4', s = 10)
    plt.legend()
    plt.xlabel("iteration")
    plt.ylabel("loss")
    plt.show()


def draw_accumulative_loss(dir):
    loss_hist = load_pickle(dir)
    accu_loss = np.cumsum(loss_hist)

    plt.plot(np.arange(len(accu_loss)), accu_loss)
    plt.xlabel("iteration")
    plt.ylabel("accumulative loss")
    plt.show()

def draw_accumulative_loss_together(dir):
    loss1 = load_pickle(dir + 'experiment1/loss_history.pickle')
    loss3 = load_pickle(dir + 'experiment3/loss_history.pickle')
    loss4 = load_pickle(dir + 'experiment4/loss_history.pickle')

    accu_loss1 = np.cumsum(loss1)
    accu_loss3 = np.cumsum(loss3)
    accu_loss4 = np.cumsum(loss4)

    fig, ax = plt.subplots()
    ax.axvspan(0, 1000000, facecolor='yellow', alpha=0.09)
    ax.axvspan(1000000, 2000000, facecolor='red', alpha=0.09)

    ax.plot(np.arange(len(accu_loss1)), accu_loss1, label = 'exp1')
    ax.plot(np.arange(len(accu_loss3)), accu_loss3, label = 'exp3')
    ax.plot(np.arange(len(accu_loss4)), accu_loss4, label = 'exp4')
    plt.legend()
    plt.text(250000, 2*1e7, 'Training', fontsize=12)
    plt.text(250000, 1.8*1e7, 'phase 1', fontsize=12)
    plt.text(1250000, 1.3*1e7, 'Training', fontsize=12)
    plt.text(1250000, 1.1*1e7, 'phase 2', fontsize=12)
    plt.xlabel("iteration")
    plt.ylabel("accumulative loss")
    plt.show()



def draw_score(dir):
    score_hist = load_pickle(dir)

    plt.scatter(np.arange(len(score_hist)), score_hist)
    plt.xlabel("episode")
    plt.ylabel("score")
    plt.show()

def draw_score_together(dir):
    score1 = load_pickle(dir + 'experiment1/score_history.pickle')
    score3 = load_pickle(dir + 'experiment3/score_history.pickle')
    score4 = load_pickle(dir + 'experiment4/score_history.pickle')

    fig, ax = plt.subplots()
    ax.axvspan(0, 1000, facecolor='yellow', alpha = 0.09)
    ax.axvspan(1000, 2000, facecolor='red', alpha = 0.09)

    ax.scatter(np.arange(len(score1)), score1, label='exp1', s = 10)
    ax.scatter(np.arange(len(score3)), score3, label='exp3', s = 10)
    ax.scatter(np.arange(len(score4)), score4, label='exp4', s = 10)
    plt.legend()
    plt.text(250, 6000, 'Training', fontsize = 12)
    plt.text(250, 5300, 'phase 1', fontsize = 12)
    plt.text(1200, 9000, 'Training', fontsize=12)
    plt.text(1200, 8300, 'phase 2', fontsize=12)
    plt.xlabel("episode")
    plt.ylabel("score")
    plt.show()


def draw_test_score(dir):
    test_score = load_pickle(dir)

    print(np.mean(test_score))

    plt.scatter(np.arange(len(test_score)), test_score)
    plt.xlabel("num of game")
    plt.ylabel("score")
    plt.show()


def main(argv):
    args = parser.parse_args(argv)
    ###### python3 history.py --dir FILE_DIRECTORY


    ###### merge two history ######
    # f1 = load_pickle(args.dir + 'loss_history_1.pickle')
    # f2 = load_pickle(args.dir + 'loss_history_2.pickle')
    # merge(f1, f2, args.dir + "loss_history.pickle")


    ###### draw history ######
    # draw_score(args.dir + "test_score_best_model.pickle")
    # draw_score(args.dir + "test_score_current_model_2000000.pickle")
    # draw_score(args.dir + "score_history.pickle")
    draw_score_together(args.dir)
    # draw_test_score(args.dir + "test_score.pickle")


    # draw_loss(args.dir + "loss_history.pickle")
    # draw_accumulative_loss(args.dir + "loss_history.pickle")
    # draw_accumulative_loss_together(args.dir)
    # draw_loss_together(args.dir)



if __name__ == "__main__":
    main(sys.argv[1:])
