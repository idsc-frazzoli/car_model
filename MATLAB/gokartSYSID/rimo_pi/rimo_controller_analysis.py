# author: az
import pandas as pd
from matplotlib import pyplot as plt


def _load_csv(number=0):
    available_files = ["20180430T135637_a5291af9", "20180814T173757_2c569ed8",
                       "20180621T120115_707a71e0", "20180814T174943_2c569ed8",
                       "20180814T111143_2c569ed8", "20180814T175821_2c569ed8"]
    target = available_files[number]
    dataframe_pi = pd.read_csv(target + "_pi.csv",
                               names=["time", "vel_error", "pPart", "iPart", "TEMP_LVE", "TEMP_LTV",
                                      "lastTor_value"], index_col=0)
    dataframe_rimo = pd.read_csv(target + "_rimo.csv",
                                 names=["time", "ang_rate_l", "ang_rate_r"], index_col=0)
    dataframe_rimo["ang_rate"] = (dataframe_rimo["ang_rate_l"] + dataframe_rimo["ang_rate_r"]) / 2
    return dataframe_pi, dataframe_rimo


def main():
    pi, rimo = _load_csv(3)
    combined = pi.join(rimo, how='outer')
    for col_name in list(combined):
        combined[col_name] = combined[col_name].interpolate("linear")
    combined["ref_rate_estimate"] = combined["ang_rate"] + combined["vel_error"]
    # print(combined["ref_rate_estimate"])
    # plotting
    ax1 = combined.plot(y=[
        "vel_error",
        "ang_rate",
        "ref_rate_estimate",
        # "iPart",
    ], color=['r', 'm', 'k'], grid=True, ylim=[-60, 60])
    ax2 = combined.plot(y=[
        "lastTor_value",
        "pPart", "iPart",
    ], secondary_y=True, ax=ax1, color=['g', 'c', 'b'], grid=True, )
    plt.show()

    print("breakpoint")


if __name__ == "__main__":
    main()
