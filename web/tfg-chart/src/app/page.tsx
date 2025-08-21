"use client";

import React, { useState, useMemo } from "react";
import { Scatter } from "react-chartjs-2";
import {
  Chart as ChartJS,
  LinearScale,
  LogarithmicScale,
  PointElement,
  LineElement,
  Tooltip as ChartJSTooltip,
  Legend as ChartJSLegend,
  Title as ChartJSTitle,
} from "chart.js";
import { BarChart3, Zap, Clock, Cpu, Monitor, Smartphone } from "lucide-react";

// Register Chart.js components once
ChartJS.register(
  LinearScale,
  LogarithmicScale,
  PointElement,
  LineElement,
  ChartJSTooltip,
  ChartJSLegend,
  ChartJSTitle
);

const COLORS: Record<string, string> = {
  "C++": "rgba(0, 0, 255, 1)", 
  "Python": "rgba(225, 126, 48, 1)", 
  "Go": "rgba(164, 32, 176, 1)", 
  "PyPy": "rgba(63, 142, 39, 1)", 
};

const PLATFORM_ICONS: Record<string, any> = {
  Server: Monitor,
  Desktop: Monitor,
  Laptop: Smartphone,
  RaspberryPi: Cpu,
};

const datasets: { x: number; y: number; label: string; language: string }[] = [
    { x: 46.58, y: 7972.65, label: "Server-1", language: "PyPy" },
    { x: 26.43, y: 5147.60, label: "Server-2", language: "PyPy" },
    { x: 13.97, y: 2828.21, label: "Server-4", language: "PyPy" },
    { x: 26.52, y: 194.69, label: "Laptop-1", language: "PyPy" },
    { x: 15.55, y: 211.21, label: "Laptop-2", language: "PyPy" },
    { x: 8.25, y: 216.53, label: "Laptop-4", language: "PyPy" },
    { x: 37.12, y: 1621.77, label: "Desktop-1", language: "PyPy" },
    { x: 21.62, y: 1324.05, label: "Desktop-2", language: "PyPy" },
    { x: 12.2871, y: 938.02, label: "Desktop-4", language: "PyPy" },
    { x: 236.67, y: 190.0, label: "RaspberryPi-1", language: "PyPy" },
    { x: 153.33, y: 152.33, label: "RaspberryPi-2", language: "PyPy" },
    { x: 107.20, y: 181.6, label: "RaspberryPi-4", language: "PyPy" },
    { x: 23.70, y: 3756.26, label: "Server-1", language: "C++" },
    { x: 12.52, y: 2591.91, label: "Server-2", language: "C++" },
    { x: 6.69, y: 1362.61, label: "Server-4", language: "C++" },
    { x: 7.48, y: 59.72, label: "Laptop-1", language: "C++" },
    { x: 3.835, y: 57.32, label: "Laptop-2", language: "C++" },
    { x: 2.06, y: 54.97, label: "Laptop-4", language: "C++" },
    { x: 22.78, y: 991.49, label: "Desktop-1", language: "C++" },
    { x: 11.71, y: 657.79, label: "Desktop-2", language: "C++" },
    { x: 6.23, y: 442.17, label: "Desktop-4", language: "C++" },
    { x: 49.26, y: 80.0, label: "RaspberryPi-1", language: "C++" },
    { x: 25.25, y: 51.67, label: "RaspberryPi-2", language: "C++" },
    { x: 12.80, y: 41.28, label: "RaspberryPi-4", language: "C++" },
    { x: 5913.41, y: 1510534.76, label: "Server-1", language: "Python" },
    { x: 4749.55, y: 1141490.15, label: "Server-2", language: "Python" },
    { x: 1665.41, y: 313537.85, label: "Server-4", language: "Python" },
    { x: 3022.81, y: 17546.05, label: "Laptop-1", language: "Python" },
    { x: 1356.76, y: 16322.57, label: "Laptop-2", language: "Python" },
    { x: 696.75, y: 16193.99, label: "Laptop-4", language: "Python" },
    { x: 6063.96, y: 272235.58, label: "Desktop-1", language: "Python" },
    { x: 3084.07, y: 174822.21, label: "Desktop-2", language: "Python" },
    { x: 1600.72, y: 112247.92, label: "Desktop-4", language: "Python" },
    { x: 8853.08, y: 11780.0, label: "RaspberryPi-1", language: "Python" },
    { x: 4423.91, y: 7620.67, label: "RaspberryPi-2", language: "Python" },
    { x: 2264.50, y: 5739, label: "RaspberryPi-4", language: "Python" },
    { x: 172.95, y: 28522.69, label: "Server-1", language: "Go" },
    { x: 89.32, y: 18231.97, label: "Server-2", language: "Go" },
    { x: 45.51, y: 10304.27, label: "Server-4", language: "Go" },
    { x: 54.16, y: 429.23, label: "Laptop-1", language: "Go" },
    { x: 28.6562, y: 370.0134, label: "Laptop-2", language: "Go" },
    { x: 14.80, y: 354.64, label: "Laptop-4", language: "Go" },
    { x: 178.98, y: 5867.26, label: "Desktop-1", language: "Go" },
    { x: 70.51968, y: 3746.84, label: "Desktop-2", language: "Go" },
    { x: 36.79, y: 2335.54, label: "Desktop-4", language: "Go" },
    { x: 165.03, y: 236.67, label: "RaspberryPi-1", language: "Go" },
    { x: 81.98, y: 153.33, label: "RaspberryPi-2", language: "Go" },
    { x: 41.10, y: 107.20, label: "RaspberryPi-4", language: "Go" },
  ];


const numberFmt = new Intl.NumberFormat("en-US", {
  maximumFractionDigits: 2,
});

type DataPoint = { x: number; y: number; label: string; language: string };

export default function EnergyVsTimeChart() {
  const allLangs = [...new Set(datasets.map(d => d.language))];
  const [selectedLangs, setSelectedLangs] = useState<string[]>(allLangs);
  const [xScaleType, setXScaleType] = useState<'linear' | 'log'>('log');
  const [yScaleType, setYScaleType] = useState<'linear' | 'log'>('log');

  // derive platforms and cores from labels like "Server-1"
  const allPlatforms = useMemo(() => {
    const set = new Set<string>();
    datasets.forEach((d) => set.add(d.label.split("-")[0]));
    return Array.from(set).sort();
  }, []);

  const allCores = useMemo(() => {
    const set = new Set<string>();
    datasets.forEach((d) => set.add(d.label.split("-")[1]));
    return Array.from(set).sort((a, b) => Number(a) - Number(b));
  }, []);

  const [selectedPlatforms, setSelectedPlatforms] = useState<string[]>(allPlatforms);
  const [selectedCores, setSelectedCores] = useState<string[]>(allCores);

  const toggleItem = (list: string[], setList: (s: string[]) => void, item: string) => {
    setList(list.includes(item) ? list.filter((x) => x !== item) : [...list, item]);
  };

  const selectAll = (items: string[], setList: (s: string[]) => void) => {
    setList(items.slice());
  };

  const selectNone = (setList: (s: string[]) => void) => {
    setList([]);
  };

  // Create a single combined dataset with all filtered data points
  const combinedData = useMemo(() => {
    return datasets.filter((d) => {
      const [plat, core] = d.label.split("-");
      return (
        selectedLangs.includes(d.language) &&
        selectedPlatforms.includes(plat) &&
        selectedCores.includes(core)
      );
    });
  }, [selectedLangs, selectedPlatforms, selectedCores]);

  const totalDataPoints = combinedData.length;

  // Build Chart.js datasets grouped by language
  const chartData = useMemo(() => {
    const byLang: Record<string, DataPoint[]> = {};
    for (const dp of combinedData) {
      if (!byLang[dp.language]) byLang[dp.language] = [];
      byLang[dp.language].push(dp);
    }
    return {
      datasets: Object.entries(byLang).map(([lang, data]) => ({
        label: lang,
        data,
        parsing: { xAxisKey: "x", yAxisKey: "y" },
        showLine: false,
        backgroundColor: COLORS[lang] || "#8884d8",
        borderColor: COLORS[lang] || "#8884d8",
        pointRadius: 4,
        pointHoverRadius: 6,
        borderWidth: 1,
        hoverBorderWidth: 2,
        opacity: 0.85,
      })),
    } as any;
  }, [combinedData]);

  // Custom external tooltip to match the card style
  const externalTooltip = React.useCallback((ctx: any) => {
    const { chart, tooltip } = ctx;
    let el = chart.canvas.parentNode.querySelector("#ext-tooltip") as HTMLDivElement | null;
    if (!el) {
      el = document.createElement("div");
      el.id = "ext-tooltip";
      el.style.position = "absolute";
      el.style.pointerEvents = "none";
      el.style.zIndex = "50";
      chart.canvas.parentNode.appendChild(el);
    }

    if (tooltip.opacity === 0) {
      el.style.opacity = "0";
      return;
    }

    const bb = chart.canvas.getBoundingClientRect();
    const dp = tooltip.dataPoints?.[0]?.raw as DataPoint | undefined;
    const dataset = tooltip.dataPoints?.[0]?.dataset ?? {};
    const lang: string = dataset?.label ?? (dp as any)?.language ?? "";
    const color: string = dataset?.borderColor || "#2563eb";
    const [platform, cores] = (dp?.label ?? "-").split("-");
    const time = dp ? numberFmt.format(dp.x) : "";
    const energy = dp ? numberFmt.format(dp.y) : "";

    el.className = "rounded-xl border bg-white/95 backdrop-blur-md p-4 shadow-lg border-gray-200 text-gray-900";
    el.innerHTML = `
      <div class="flex items-center gap-2 mb-2">
        <span class="inline-block w-3 h-3 rounded-full" style="background:${color}"></span>
        <span class="font-semibold">${lang}</span>
      </div>
      <div class="text-sm text-gray-800 mb-1">${platform} • ${cores} core${cores !== "1" ? "s" : ""}</div>
      <div class="grid grid-cols-2 gap-3 text-xs">
        <div class="flex items-center gap-1">
          <span class="inline-flex items-center justify-center w-3 h-3">⏱️</span>
          <span class="text-gray-800">${time} s</span>
        </div>
        <div class="flex items-center gap-1">
          <span class="inline-flex items-center justify-center w-3 h-3">⚡</span>
          <span class="text-gray-800">${energy} J</span>
        </div>
      </div>
    `;

    // Position near caret; clamp within parent bounds
    const parentBB = (chart.canvas.parentNode as HTMLElement).getBoundingClientRect();
    const x = bb.left + window.scrollX + tooltip.caretX - parentBB.left - el.offsetWidth / 2;
    const y = bb.top + window.scrollY + tooltip.caretY - parentBB.top - el.offsetHeight - 12;
    el.style.left = Math.max(8, Math.min(x, parentBB.width - el.offsetWidth - 8)) + "px";
    el.style.top = Math.max(8, y) + "px";
    el.style.opacity = "1";
  }, []);

  const options = useMemo(() => {
    return {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { position: "top" as const },
        title: {
          display: false,
          text: "Energy Consumption vs Execution Time",
        },
        tooltip: {
          enabled: false,
          external: externalTooltip as any,
        },
      },
      scales: {
        x: {
          type: xScaleType === "log" ? "logarithmic" : "linear",
          title: { display: true, text: "Time (s)" },
          grid: { color: "#e2e8f0" },
          ticks: {
            callback(value: any) {
              const v = typeof value === "string" ? Number(value) : value;
              return numberFmt.format(v);
            },
          },
        },
        y: {
          type: yScaleType === "log" ? "logarithmic" : "linear",
          title: { display: true, text: "Energy (J)" },
          grid: { color: "#e2e8f0" },
          ticks: {
            callback(value: any) {
              const v = typeof value === "string" ? Number(value) : value;
              return numberFmt.format(v);
            },
          },
        },
      },
      elements: {
        point: {
          borderWidth: 1,
        },
      },
    } as any;
  }, [xScaleType, yScaleType]);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
      <div className="max-w-12xl mx-auto p-6">
        {/* Header */}
        <div className="text-center mb-4">
          <div className="flex items-center justify-center gap-3">
            <BarChart3 className="w-8 h-8 text-blue-600" />
            <h1 className="text-3xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
              Programming Language Performance Comparaison
            </h1>
          </div>
          {/* <p className="text-md text-gray-600 max-w-3xl mx-auto">
            Interactive comparison of execution time vs energy consumption across different platforms and core counts
          </p> */}
        </div>

        {/* Controls */}
        <div className="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-8">
          {/* Chart */}
          <div className="xl:col-span-2 bg-white/80 backdrop-blur-sm rounded-xl p-6 shadow-lg border border-white/20">
            <div className="flex items-center gap-2 mb-4">
              <BarChart3 className="w-5 h-5 text-blue-600" />
              <h3 className="text-lg font-semibold text-gray-800">
                Energy Consumption vs Execution Time
              </h3>
              <div className="ml-auto text-sm text-gray-500">
                {xScaleType === 'log' ? 'Log' : 'Linear'} × {yScaleType === 'log' ? 'Log' : 'Linear'} scale
              </div>
            </div>
            
            {totalDataPoints === 0 ? (
              <div className="h-96 flex items-center justify-center text-gray-500">
                <div className="text-center">
                  <BarChart3 className="w-12 h-12 mx-auto mb-4 opacity-50" />
                  <p className="text-lg font-medium">No data to display</p>
                  <p className="text-sm">Select at least one language, platform, and core count</p>
                </div>
              </div>
            ) : (
              <div className="h-[500px]">
                <Scatter data={chartData} options={options} />
              </div>
            )}
          </div>

          {/* Control Panel */}
          <div className="space-y-3">
            {/* Languages */}
            <div className="bg-white/80 backdrop-blur-sm p-4 rounded-xl shadow-lg border border-white/20">
              <div className="flex items-center justify-between mb-3">
                <h2 className="font-semibold text-gray-800 flex items-center gap-2">
                  <div className="w-2 h-2 rounded-full bg-blue-500" />
                  Languages
                </h2>
                <div className="flex gap-1">
                  <button
                    onClick={() => selectAll(allLangs, setSelectedLangs)}
                    className="text-xs text-blue-600 hover:text-blue-800 font-medium"
                  >
                    All
                  </button>
                  <span className="text-gray-300">|</span>
                  <button
                    onClick={() => selectNone(setSelectedLangs)}
                    className="text-xs text-gray-500 hover:text-gray-700 font-medium"
                  >
                    None
                  </button>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-2">
                {allLangs.map((lang) => (
                  <button
                    key={lang}
                    onClick={() => toggleItem(selectedLangs, setSelectedLangs, lang)}
                    className={`flex items-center gap-2 px-3 py-2 rounded-lg border transition-all duration-200 ${
                      selectedLangs.includes(lang) 
                        ? 'bg-white text-gray-900 shadow-md border-gray-300 ring-2 transform scale-[1.02]' 
                        : 'bg-gray-50 hover:bg-gray-100 border-gray-200 text-gray-700'
                    }`}
                    style={{ 
                      borderColor: selectedLangs.includes(lang) ? COLORS[lang] : undefined
                    }}
                  >
                    <span className="w-3 h-3 rounded-full border-2" style={{ backgroundColor: COLORS[lang], borderColor: COLORS[lang] }} />
                    <span className="font-medium text-sm truncate">{lang}</span>
                  </button>
                ))}
              </div>
            </div>

            {/* Platforms */}
            <div className="bg-white/80 backdrop-blur-sm p-4 rounded-xl shadow-lg border border-white/20">
              <div className="flex items-center justify-between mb-3">
                <h2 className="font-semibold text-gray-800 flex items-center gap-2">
                  <div className="w-2 h-2 rounded-full bg-green-500" />
                  Platforms
                </h2>
                <div className="flex gap-1">
                  <button
                    onClick={() => selectAll(allPlatforms, setSelectedPlatforms)}
                    className="text-xs text-green-600 hover:text-green-800 font-medium"
                  >
                    All
                  </button>
                  <span className="text-gray-300">|</span>
                  <button
                    onClick={() => selectNone(setSelectedPlatforms)}
                    className="text-xs text-gray-500 hover:text-gray-700 font-medium"
                  >
                    None
                  </button>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-2">
                {allPlatforms.map((platform) => {
                  const IconComponent = PLATFORM_ICONS[platform] || Monitor;
                  return (
                    <button
                      key={platform}
                      onClick={() => toggleItem(selectedPlatforms, setSelectedPlatforms, platform)}
                      className={`flex items-center gap-2 px-3 py-2 rounded-lg border transition-all duration-200 ${
                        selectedPlatforms.includes(platform) 
                          ? 'bg-white text-gray-900 shadow-md border-green-500 ring-2 ring-green-500 transform scale-[1.02]' 
                          : 'bg-gray-50 hover:bg-gray-100 border-gray-200 text-gray-700'
                      }`}
                    >
                      <IconComponent className="w-3 h-3 text-green-600 flex-shrink-0" />
                      <span className="font-medium text-xs truncate">{platform}</span>
                    </button>
                  );
                })}
              </div>
            </div>

            {/* Cores */}
            <div className="bg-white/80 backdrop-blur-sm p-4 rounded-xl shadow-lg border border-white/20">
              <div className="flex items-center justify-between mb-3">
                <h2 className="font-semibold text-gray-800 flex items-center gap-2">
                  <div className="w-2 h-2 rounded-full bg-purple-500" />
                  CPU Cores
                </h2>
                <div className="flex gap-1">
                  <button
                    onClick={() => selectAll(allCores, setSelectedCores)}
                    className="text-xs text-purple-600 hover:text-purple-800 font-medium"
                  >
                    All
                  </button>
                  <span className="text-gray-300">|</span>
                  <button
                    onClick={() => selectNone(setSelectedCores)}
                    className="text-xs text-gray-500 hover:text-gray-700 font-medium"
                  >
                    None
                  </button>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-2">
                {allCores.map((cores) => (
                  <button
                    key={cores}
                    onClick={() => toggleItem(selectedCores, setSelectedCores, cores)}
                    className={`relative flex items-center justify-center gap-2 px-3 py-2 rounded-lg border transition-all duration-200 ${
                      selectedCores.includes(cores) 
                        ? 'bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-md border-purple-400 transform scale-[1.02]' 
                        : 'bg-gray-50 hover:bg-purple-50 border-gray-200 hover:border-purple-300 text-gray-700'
                    }`}
                  >
                    <Cpu className={`w-3 h-3 ${selectedCores.includes(cores) ? 'text-white' : 'text-purple-600'}`} />
                    <span className="font-medium text-sm">{cores}</span>
                    {selectedCores.includes(cores) && (
                      <div className="absolute -top-0.5 -right-0.5 w-2 h-2 bg-green-500 rounded-full" />
                    )}
                  </button>
                ))}
              </div>
            </div>

            {/* Chart Options */}
            <div className="bg-white/80 backdrop-blur-sm p-4 rounded-xl shadow-lg border border-white/20">
              <h2 className="font-semibold text-gray-800 mb-3 flex items-center gap-2">
                <div className="w-2 h-2 rounded-full bg-amber-500" />
                Chart Options
              </h2>
              <div className="space-y-3">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Y-Axis Scale (Energy)
                  </label>
                  <div className="relative inline-flex items-center bg-gray-200 rounded-lg p-1 w-full">
                    <button
                      onClick={() => setYScaleType('linear')}
                      className={`relative z-10 px-3 py-1 text-sm font-medium rounded-md transition-all duration-200 flex-1 ${
                        yScaleType === 'linear' 
                          ? 'bg-amber-500 text-white shadow-sm' 
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Linear
                    </button>
                    <button
                      onClick={() => setYScaleType('log')}
                      className={`relative z-10 px-3 py-1 text-sm font-medium rounded-md transition-all duration-200 flex-1 ${
                        yScaleType === 'log' 
                          ? 'bg-amber-500 text-white shadow-sm' 
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Log
                    </button>
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    X-Axis Scale (Time)
                  </label>
                  <div className="relative inline-flex items-center bg-gray-200 rounded-lg p-1 w-full">
                    <button
                      onClick={() => setXScaleType('linear')}
                      className={`relative z-10 px-3 py-1 text-sm font-medium rounded-md transition-all duration-200 flex-1 ${
                        xScaleType === 'linear' 
                          ? 'bg-blue-500 text-white shadow-sm' 
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Linear
                    </button>
                    <button
                      onClick={() => setXScaleType('log')}
                      className={`relative z-10 px-3 py-1 text-sm font-medium rounded-md transition-all duration-200 flex-1 ${
                        xScaleType === 'log' 
                          ? 'bg-blue-500 text-white shadow-sm' 
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Log
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  );
}